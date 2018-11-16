function urlBase64ToUint8Array(base64String) {
    //文字列→unit8に変換する関数
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
      .replace(/\-/g, '+')
      .replace(/_/g, '/');
  
    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);
  
    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
  }

function encodeBase64URL(buffer) {
    //Base64エンコードを行う関数
    return btoa(String.fromCharCode.apply(null, new Uint8Array(buffer)))
             .replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  }


//以下、serviceWorkerの動作を記述//
document.addEventListener('DOMContentLoaded', function(){
    //console.log("load is OK!");
    if('serviceWorker' in navigator){
        //serviceWorkerに対応している場合、クライアントブラウザにインストールする
        navigator.serviceWorker.register('sw_for_user.js');
        console.log("register is OK!");
        
        navigator.serviceWorker.ready.then(
            function(registration){
                //console.log("ready is OK!");
                return registration.pushManager.getSubscription().then(
                    function(subscription){
                        //すでに登録済みの場合
                        if(subscription){
                            console.log("getsubscription is OK!");
                            return subscription
                        }

                        //未登録の場合
                        console.log("subscription is OK!");
                        fetch('/endpoint#getVapidPublicKey').then(function(responce){
                            return responce.json(); //VAPID(サーバ側で生成したもの)を取得
                        }).then(function(keyJson){
                            const convertedVapidKey = urlBase64ToUint8Array(keyJson.vapidPublicKey); //unit8に変換
                            return convertedVapidKey;
                        }).then(function(convKey){
                            return registration.pushManager.subscribe({
                                userVisibleOnly: true,
                                applicationServerKey: convertedVapidKey //VAPIDで使用するサーバ公開鍵
                            })
                        });
                    }
                )
            }
        ).then(
            //以下は購読成功時の処理
            function(subscription){
                const endpoint = subscription.endpoint; //エンドポイントURL
                console.log("pushManager RegistrationID:", endpoint.split("/").slice(-1).join());
                publicKey = encodeBase64URL(subscription.getKey('p256dh')); //クライアント公開鍵
                const publicKey_pem = "-----BEGIN EC PUBLIC KEY-----\n" + publicKey + "\n-----END EC PUBLIC KEY-----\n"
                const authSecret = encodeBase64URL(subscription.getKey('auth')); //auth secret
                let contentEncoding; //プッシュ通知のときに使用するContent-Encoding
                if ('supportedContentEncodings' in PushManager) {
                    contentEncoding = PushManager.supportedContentEncodings.includes('aes128gcm') ? 'aes128gcm' : 'aesgcm';
                }
                  else{
                    contentEncoding = 'aesgcm';
                }
                //以上の4つのパラメーターをDBに登録しておく

                //fetch APIを使用してサーバに送信
                fetch('/endpoint', {
                    credentials: 'include',
                    method: 'POST',
                    headers: {'Content-Type': 'application/json; charset=UTF-8'},
                    body: JSON.stringify({
                        endpoint: endpoint,
                        publicKey: publicKey_pem,
                        auth: authSecret,
                        contentEncoding: contentEncoding
                    })
                });

                /*RegistrationIDをrailsにgetで送信
                var xhr = new XMLHttpRequest();
                xhr.open('GET', "/endpoints?id=" + endpoint.split("/").slice(-1).join());
                xhr.send();*/
            }
        ).catch(function(error){
            console.warn("serviceWorker error:", error);
        })
    }
})
