$(document).on('ready turbolinks:load', function () {
    // This is called on the first page load *and* also when the page is changed by turbolinks
});

function sleep(ms){
    return new Promise(resolve => setTimeout(resolve, ms))
}
