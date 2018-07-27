document.addEventListener('DOMContentLoaded', function(){
    console.log("load is OK!");
    if('serviceWorker' in navigator){
        navigator.serviceWorker.register('sw_for_user.js', {scope: "/"});
        console.log("register is OK!");
        navigator.serviceWorker.ready.then(
            function(registration){
                console.log("ready is OK!")
                return registration.pushManager.getSubscription().then(
                    function(subscription){
                        if(subscription){
                            console.log("getsubscription is OK!");
                            return subscription
                        }
                        console.log("subscription is OK!")
                        return registration.pushManager.subscribe({userVisibleOnly: true});
                    }
                )
            }
        ).then(
            function(subscription){
                var endpoint = subscription.endpoint;
                console.log("pushManager RegistrationID:", endpoint.split("/").slice(-1).join());
                console.log("pushManager endpoint:", endpoint);
            }
        ).catch(function(error){
            console.warn("serviceWorker error:", error);
        })
    }
})
