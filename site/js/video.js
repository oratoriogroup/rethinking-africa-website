/* Rethinking Africa with Dr. Damola: click-to-play YouTube facade.
   The YouTube player is NOT loaded when the page opens. Only a thumbnail is shown.
   The player loads only after the visitor presses play. Nothing ever autoplays on page load.
   To add a video, put its 11-character YouTube ID in the data-yt attribute, e.g. data-yt="dQw4w9WgXcQ".
   With no ID, the box links to the YouTube channel instead. */
(function(){
  var ok=/^[A-Za-z0-9_-]{11}$/;
  var boxes=document.querySelectorAll('a.yt-facade');
  for(var i=0;i<boxes.length;i++){(function(a){
    var id=(a.getAttribute('data-yt')||'').trim();
    if(!ok.test(id)){return;}
    a.href='https://www.youtube.com/watch?v='+id;
    a.classList.add('has-video');
    var img=document.createElement('img');
    img.src='https://i.ytimg.com/vi/'+id+'/hqdefault.jpg';
    img.alt='';img.loading='lazy';img.decoding='async';
    a.insertBefore(img,a.firstChild);
    a.addEventListener('click',function(e){
      e.preventDefault();
      var f=document.createElement('iframe');
      f.src='https://www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&modestbranding=1';
      f.title=a.getAttribute('data-title')||'Video';
      f.allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture';
      f.allowFullscreen=true;
      a.parentNode.replaceChild(f,a);
      f.focus();
    });
  })(boxes[i]);}
})();
