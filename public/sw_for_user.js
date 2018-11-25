<<<<<<< HEAD
self.addEventListener('push', function(evt){
    console.log("Notification start");
    evt.waitUntil(
        self.registration.showNotification('今だらだらしてた？',
            {
                body: "今暇か？",
                actions: [{
                    action: "yes",
                    title: "暇や"
                }, {
                    action: "no",
                    title: "暇じゃない"
                }],
                vibrate: [200, 100, 200, 100, 200, 100, 200]
            }
        )
    );
}, false);

self.addEventListener('notificationclick', function(event){
    event.notification.close();
        if(event.action == "yes"){
            self.registration.showNotification(
                'やっていく気持ち', 
                {
                    body: "タスクやる？",
                    actions: [{
                        action: "yes2",
                        title: "やっていき"
                    }, {
                        action: "no2",
                        title: "ダメ"
                    }
                    ]
                }
            )
        }
        else if(event.action == "yes2"){
            console.log("openwindow");
            clients.openWindow("/tasks/94?timer=1");
        }
=======
self.addEventListener('push', function(evt){
    console.log("Notification start");

    //通知送信時のmessage:の中身を取得(json形式)
    var json = evt.data.json(); 
    evt.waitUntil(
        self.registration.showNotification('今だらだらしてた？',
            {
                body: json.body.name + "が最優先タスクとして残ってるよ！",
                actions: [{
                    action: "yes",
                    title: "5分だけチャレンジ"
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
>>>>>>> 679a1ae9f6ca593c00bd365604ad0fa6fbae16aa
}, false);