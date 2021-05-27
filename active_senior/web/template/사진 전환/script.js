var carousel = $(".carousel"),
    items = $(".item"),
    currdeg  = 0;



let item_id = { 0: "#a", 300: "#b", 240: "#c", 180: "#d", 120: "#e", 60: "#f" }

$("#b").on('click', { d: "n" }, rotate)
$("#a").on('click', () => {location.href ="http://www.naver.com"})
$("#f").on('click', { d: "p" }, rotate)


function rotate(e){
  $(item_id[((currdeg - 60) % 360 + 360) % 360]).off('click')
  $(item_id[((currdeg) % 360 + 360) % 360]).off('click')
  $(item_id[((currdeg + 60) % 360 + 360) % 360]).off('click')

  if(e.data.d=="n"){
    currdeg = currdeg - 60;
  }
  if(e.data.d=="p"){
    currdeg = currdeg + 60;
  }


  $(item_id[((currdeg - 60) % 360 + 360) % 360]).on('click', { d: "n" }, rotate)
  $(item_id[((currdeg) % 360 + 360) % 360]).on('click', () => {location.href ="http://www.naver.com"})
  $(item_id[((currdeg + 60) % 360 + 360) % 360]).on('click', { d: "p" }, rotate)

  console.log(currdeg)


  carousel.css({
    "-webkit-transform": "rotateY("+currdeg+"deg)",
    "-moz-transform": "rotateY("+currdeg+"deg)",
    "-o-transform": "rotateY("+currdeg+"deg)",
    "transform": "rotateY("+currdeg+"deg)"
  });
    items.css({
    "-webkit-transform": "rotateY("+(-currdeg)+"deg)",
    "-moz-transform": "rotateY("+(-currdeg)+"deg)",
    "-o-transform": "rotateY("+(-currdeg)+"deg)",
    "transform": "rotateY("+(-currdeg)+"deg)"
  });
}