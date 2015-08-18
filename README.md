#Analytics
see [Guide](http://www.ohow.co/what-is-referrer-spam-how-stop-it-guide/)

----
## Include filter (add new pages!)
Valid hostnames expression:
        
    violencia\.click|translateservice\.com|yourshoppingcart\.com|otherservice\.net
    violencia\.click

> This filter doesn’t require much maintenance but is **VERY IMPORTANT** that every time you add a Hostname, or you include your tracking-ID in any service like PayPal or youtube, you include it at the end of the **REGEX**.

----
## Crawler spam filter
Spam hostnames expression:
        
    (best|100dollars|success)\-seo|(videos|buttons)\-for|anticrawler|musica\-gratis|semalt|forum69|7makemoney|sharebutton|ranksonic|sitevaluation|dailyrank
    free|tracking|erot|button

----
## Increase GA Tag
1. Create new GA Tag (UA-xxxxxxx-2)
2. Change Google Tag Manager from (UA-xxxxxxx-1) to (UA-xxxxxxx-2)

### Google Analytics: Increase GA Tag
* Admin > Property > Create new property
* Name: violencia-2
* Demais dados iguais (violencia.click | Fuso horário, etc)

### Update Google Tag Manager with new GA Tag
* Container > Tags > "Violencia.click Site GA Tag"
* Tracking ID
* Change final digit from 1 to 2
* from (UA-xxxxxxx-1) to (UA-xxxxxxx-2)
* Click "Publish" button