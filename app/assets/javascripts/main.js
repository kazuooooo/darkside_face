

var container = $('#container');
var icontainer = $('#image-container');
var img = $('#img');


// 初期化
function initialize(data){
  icontainer.css({
    position: 'relative',
    width: data.img_width,
    height: data.img_height
  });

  photo.attr({
    src: data.url
  }).css({
    // position: "absolute",
  });
}

function set_item(data){

  data.face.map(function(face){

    var f = {
      width: data.img_width * (face.position.width / 100), //px
      height: data.img_height * (face.position.height / 100), //px
    }

    var item = $("<img>").attr({
      src: "/mask01.png"
    })
    .css({
      position: 'absolute',
      top: data.img_width * (face.position.center.x / 100) - 250,
      left: data.img_height * (face.position.center.y / 100) - 250,
      width: 500,
      height: 500,
      transform: "rotate(" + face.attribute.pose.roll_angle.value + "deg)",
    });


    icontainer.append(item);
  });
}

function main(){
    initialize(data);
    set_item(data);

    $("#button").on('click', function(){
      console.log("hello");
    });
}

$(function(){
  $("#img").bind('load', function(){
    var data = $.parseJSON(img.attr('data-json'));
    main(data);
  });
});
