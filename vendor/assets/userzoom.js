(function(obj) {
    var rand = Math.floor((Math.random() * 100) + 1),
        incremental = 0;
    function addSICode(obj, key) {
        //console.log("Here " + rand);
        if (obj.cookieName) {
            window._uzactions = window._uzactions || [];
            window._uzactions.push(['_setCookie', obj.cookieName]);
        }
        (function() {
            var uz = document.createElement('script');
            uz.type = 'text/javascript';
            uz.async = true;
            uz.charset = 'utf-8';
            uz.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'cdn4.userzoom.com/files/js/' + obj.studies[key].code + '.js?t=uz_' + obj.studies[key].type + '&cuid=' + obj.cuid;
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(uz, s);
        })();
    }
    for (key in obj.studies) {
        var study = obj.studies[key];
        if (rand > incremental && rand <= (incremental + study.percent)) {
            addSICode(obj, key);
            break;
        }
        incremental += study.percent;
        if (incremental > 100) break;
    }
})
({
    // Cookie Name. Sets a name for UZ's cookie.
    // Delete the whole line to do not use cookie sharing between studies.
    cookieName: 'UZ_IntCookie',
    // List of studies to be included in the randomization.
    studies: [{
        // Study trigger frequency
        // Defines the percentage at which each study will be triggered
        percent: 50,
        // Study permanent intercept code
        // Defines the permanent intercept code associated with each randomization.
        code: 'QzcwNFQx',
        // Study type
        // Defines if user will be intercepted via feedback tab or site intercept
        type: 'til'
    }, {
        percent: 50,
        code: 'QzcwNFQy',
        type: 'til'
    }],
    // CUID Code. Sets a code for UZ's client.
    // Modify only by UserZoom Support Team.
    cuid: 'C85E515772DAE311BEDA0022196C4538'
});