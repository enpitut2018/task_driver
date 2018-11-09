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
}, false);