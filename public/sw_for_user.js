self.addEventListener('push', function(evt){
    console.log("Notification start");
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
                    target_url: 
                }
                vibrate: [200, 100, 200, 100, 200, 100, 200]
            }
        )
    );
}, false);

self.addEventListener('notificationclick', function(event){
    event.notification.close();
    console.log("openwindow");
    clients.openWindow("/tasks/importance");
}, false);