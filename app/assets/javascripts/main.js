
console.log(data);

var container = $('#container');
var icontainer = $('#image-container');
var photo = $('#photo');

// 初期化
function initialize(){
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

function set_item(){



  data.face.map(function(face){

    var type = [1,2,3,4];
    type.map(function(){

    var f = {
      width: data.img_width * (face.position.width / 100), //px
      height: data.img_height * (face.position.height / 100), //px
    }


    var image = $("<div>").css({
      position: 'absolute',
      top: data.img_width * (face.position.center.x / 100) - 250,
      left: data.img_height * (face.position.center.y / 100) - 250,
      width: 500,
      height: 500,
      transform: "rotate(" + face.attribute.pose.roll_angle.value + "deg)",
      background: 'red',
      opacity: 0.5});


    var item = $('<img>').attr({
      src: image,
    }).css({
      position: 'absolute',
      transform: "rotate(" + face.attribute.pose.roll_angle + "deg)"
    });

    icontainer.append(image);
    // icontainer.append(item);
  });

  });
}



function main(){
    initialize();
    set_item();

    $("#button").on('click', function(){
      console.log("hello");
    });
}

main();
