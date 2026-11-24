/* Rethinking Africa with Dr. Damola: YouTube video boxes.
   To add a video, put its 11-character YouTube ID in the data-yt attribute, e.g. data-yt="dQw4w9WgXcQ".
   With no ID, the box links to the YouTube channel instead.

   Default: click-to-play. Only a thumbnail loads; the player loads when the visitor presses play.

   data-autoplay: the video starts by itself, MUTED, once the box is on screen
   (browsers block autoplay with sound, and the project rule is never to autoplay with sound).
   The visitor taps the player's unmute button to hear it. Autoplay is skipped, and the box
   stays click-to-play, when the visitor has data saver on, is on a 2G connection, or has
   asked their device to reduce motion. */
(function(){
  var ok=/^[A-Za-z0-9_-]{11}$/;

  function canAutoplay(){
    var c=navigator.connection||{};
    if(c.saveData) return false;
    if(/(^|-)2g$/.test(c.effectiveType||'')) return false;
    if(window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches) return false;
    return true;
  }

  function play(a,id,muted){
    var f=document.createElement('iframe');
    var q=muted
      ? 'autoplay=1&mute=1&playsinline=1&loop=1&playlist='+id+'&cc_load_policy=1&rel=0&modestbranding=1'
      : 'autoplay=1&playsinline=1&rel=0&modestbranding=1';
    f.src='https://www.youtube-nocookie.com/embed/'+id+'?'+q;
    f.title=a.getAttribute('data-title')||'Video';
    f.allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture';
    f.allowFullscreen=true;
    f.loading='lazy';
    a.parentNode.replaceChild(f,a);
    return f;
  }

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
      play(a,id,false).focus();
    });

    if(a.hasAttribute('data-autoplay') && canAutoplay()){
      var start=function(){ if(a.parentNode) play(a,id,true); };
      if('IntersectionObserver' in window){
        // Start once any part of the video is on screen (or within 100px of it),
        // so even a quick swipe past the video starts it.
        var io=new IntersectionObserver(function(entries){
          for(var k=0;k<entries.length;k++){ if(entries[k].isIntersecting){ io.disconnect(); start(); } }
        },{threshold:0,rootMargin:'100px 0px'});
        io.observe(a);
      } else { start(); }
    }
  })(boxes[i]);}
})();
