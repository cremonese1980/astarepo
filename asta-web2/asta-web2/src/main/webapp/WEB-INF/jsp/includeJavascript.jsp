
<script src="${web}/shared/js/base2.js"></script>
<script src="${web}/shared/js/jQuery-min-1.10.2.js"></script>
<script src="${web}/shared/js/core.js?${startupTime}"></script>
<script>core.isTest = ${publicService.test};</script>
<script src="${web}/shared/js/jquery.base.forms-min.js?${startupTime}"></script>

<%-- CountDownObject --%>
<script>
	$.countdown = function () {
	    var args = arguments[0] || {};
	    var serverDiff = Math.round((new Date() - args.serverDate)/1000);
	    var _countdown = function () {
	        today_date = new Date();
	        today_date.setSeconds(today_date.getSeconds()-serverDiff);
	        var o = today_date.DiffToDate(args.expirationDate);
	        $('#' +  args.days).text(o.days);$('#' + args.hours).text(o.hours);$('#' +  args.minutes).text(o.minutes);$('#' +  args.seconds).text(o.seconds);	
	    }
	    _countdown();
	    setInterval(_countdown, 1000);
	};
</script>

<%---- INCLUDE JAVASCRIPT ----%>
<template:get key="head.script"><template:get key="head.script.add" /></template:get>