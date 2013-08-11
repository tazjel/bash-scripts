/*jslint white:true browser:true devel:true sloppy:true*/
/*global require:true, $:true, phantom:true*/

var system = require('system');
var page = require('webpage').create();
var url = system.args[1];

// page.customHeaders = {
//   'Accept-Encoding': 'deflate,gzip'
// };

var image_urls;

page.open(url, function (status) {
  // page.includeJs("//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js", function () {
  //   return $("img").map(function () { return $(this).attr("href"); });
  // });
  image_urls = page.evaluate(function () {
    var images = Array.prototype.slice.call(document.body.querySelectorAll('img'));
    return images.map(function (img) { return img.src; });
  });

  console.log(image_urls.join("\n"));

  page.open(image_urls[10], function () {
    // return page.renderBase64('PNG');
    page.render('PNG');
    console.log(page.renderBase64('PNG'));
    phantom.exit();
  });
});


// var page = require('webpage').create();
// page.open('http://google.com', function () {
//   page.zoomFactor = 0.25;
//   console.log(page.renderBase64('PNG'));
//   phantom.exit();
// });

// http://ariya.ofilabs.com/2012/10/web-page-screenshot-with-phantomjs.html

// page.onCallback = function(msg) {
//   console.log("page calling phantom with:" + msg);
// };

// url = "http://phantomjs.org/";

// page.open(url, function (status) {
//   console.log("now open localhost:9000 and find the second webkit inspector page");
//   debugger;  // this is necessary
//   page.evaluate(function() {
//     setTimeout(function(){
//       debugger;
//       window.callPhantom("done");
//     }, 0);
//   });
// });

// var system = require('system');
// var page = require('webpage').create();

// function debugPage() {
//   console.log("Refresh a second debugger-port page and open a second webkit inspector for the target page.");
//   console.log("Letting this page continue will then trigger a break in the target page.");
//   debugger; // pause here in first web browser tab for steps 5 & 6
//   page.evaluateAsync(function() {
//     debugger; // step 7 will wait here in the second web browser tab
//   });
// }

// debugPage();
// // phantom.exit();


// /*

//   1. start on command line with remote-debugger-port option.
//   2. navigate to debugging port in web browser
//   3. get first web inspector for phantom context
//   4. from the web browser console execute __run(), which will hit first debugger point
//   5. navigate to debugging port in a second web browser tab
//   6. get second web inspector (for page context)
//   7. return to the first web inspector tab and click continue on debugger
//   8. navigate back to second tab and you should find debugger waiting

// */


