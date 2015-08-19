#Marketing
see a [Guide](http://www.nichepursuits.com/welcome-to-the-authority-site-project/)
* Pick a brandable domain.
* Develop an overall vision for what we want to accomplish with the site, and how we can stand out.
* Research and pick hundreds of long tail keywords (Long Tail Pro?) that fit our target.
* Build or purchase a premium theme, hire someone to design a logo.
* Hire an author to start writing out 3000 word articles for each of our chosen keywords.  Add 1 of these articles each weekday.
* Also post 2 to 3 shorter news articles a day.
* Create a Facebook and Twitter account to establish a social presence.
* Brainstorm ideas for content that may not be keyword based, but is highly shareable and useful.
* Create a unique page on our site that related sites in our industry will mention.
* Manually via email reach out to hundreds of organizations to essentially ask for links to our unique page.
* Publish a massive resource that we expect to use as “link bait”.
* Use Reddit and other resources to get exposure to this massive resource.
* Continuing brainstorm additional “resource” ideas or highly shareable content that we can use to get attention, traffic, and links.
* Brainstorm kindle eBook ideas for our market. We came up with half a dozen potential titles.
* Eventually write our first Kindle eBook. Then hire people to format and create a book cover.
* Create a lead magnet and got email opt in forms all set up. Creating an email list is important.
* Submit site to Google news (can be rejected if done incorrectly!).
* Start testing Facebook ads. Build email list.

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