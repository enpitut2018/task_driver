self.addEventListener('push', function(evt){
    //通知送信時のmessage:の中身を取得(json形式)
    var json = evt.data.json(); 
    evt.waitUntil(
        self.registration.showNotification('今だらだらしてた？',
            {
                body: json.body.name,
                actions: [{
                    action: "yes",
                    title: "5分だけでもチャレンジ"
                }, {
                    action: "no",
                    title: "やる気がでません"
                }],
                data: {
                    target_url: json.body.target_url + json.body.id + "?timer=1"
                },
                vibrate: [200, 100, 200, 100, 200, 100, 200]
            }
        )
    );
}, false);

self.addEventListener('notificationclick', function(event){
    event.notification.close();
    console.log("openwindow");
    clients.openWindow(event.notification.data != null ? event.notification.data.target_url : '/');
}, false);