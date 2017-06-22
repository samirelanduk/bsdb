            $(document).ready(function () {
                $.cookieCuttr({
                    cookieAnalytics: false,
                    cookieMessage: 'We use cookies on this website, you can <a href="{{cookiePolicyLink}}" title="read about our cookies and change your preference">read about them and update your preference here</a>. To use the website as intended please...',
                    cookiePolicyLink: '/privacyPolicy.jsp',
                    cookieNotificationLocationBottom: true,
                    cookieDomain: "guidetopharmacology.org"
                });
            }); 
            
            if (jQuery.cookie('cc_cookie_decline') == "cc_cookie_decline") {
                // do nothing
            } else {
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-2713603-2']);
	        _gaq.push(['_setDomainName', 'guidetopharmacology.org']);
                _gaq.push(['_trackPageview']);

                (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document. getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
            }
       
      function recordEvent(link, category, action, label) {
	  _gaq.push(['_trackEvent', category, action, label]);
	  //setTimeout('document.location = "' + link.href + '"', 100);
	  setTimeout(window.open(link.href, '_blank'), 100);
      }