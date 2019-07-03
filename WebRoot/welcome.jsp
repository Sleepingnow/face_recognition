<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>tracking.js - face with camera</title>
  <link rel="stylesheet" href="assets/demo.css">
  <script src="./js/jquery-3.3.1.min.js"></script>
  <script src="./js/tracking-min.js"></script>
  <script src="./js/face-min.js"></script>
   <script src="node_modules/dat.gui/build/dat.gui.min.js"></script>
  <script src="assets/stats.min.js"></script>

  <style>
        * {
            padding: 0;
            margin: 0;
        }

        .container {
            position: relative;
            width: 581px;
            height: 436px;
            float:left;
        }

        .message{
        	float:left;
        }

        video, #canvas {
            position: absolute;
            width: 581px;
            height: 436px;
        }
		
    	.alert {
    		display: none;
    		position: fixed;
    		top: 50%;
    		left: 50%;
		    min-width: 200px;
		    margin-left: -100px;
		    z-index: 99999;
		    padding: 15px;
		    border: 1px solid transparent;
		    border-radius: 4px;
		}

		.alert-success {
			color: #3c763d;
		    background-color: #dff0d8;		
		    border-color: #d6e9c6;		
		}
		 
		.alert-info {
		    color: #31708f;		
		    background-color: #d9edf7;		
		    border-color: #bce8f1;		
		}

		.alert-warning {
            color: #8a6d3b;
	    	background-color: #fcf8e3;	
	    	border-color: #faebcc;
		}

		.alert-danger {
    		color: #a94442;
    		background-color: #f2dede;
   			border-color: #ebccd1;
		}
    </style>
</head>
<body>
  <div class="container">
	    <video id="video" preload autoplay loop muted></video>
	    <canvas id="canvas" width="581" height="436"></canvas>
	</div>
	<div class="message">
		<canvas id="shortCut" width="290" height="218" ></canvas>
		<div id="checkinMsg"></div>
	</div>

  <script>
    window.onload = function() {
      var video = document.getElementById('video');
      var canvas = document.getElementById('canvas');
      var context = canvas.getContext('2d');
      var shortCut = document.getElementById('shortCut');
      var scContext = shortCut.getContext('2d');
      var tracker = new tracking.ObjectTracker('face');
      tracker.setInitialScale(4);
      tracker.setStepSize(2);
      tracker.setEdgesDensity(0.1);

      tracking.track('#video', tracker, { camera: true });

      tracker.on('track', function(event) {
        context.clearRect(0, 0, canvas.width, canvas.height);

        event.data.forEach(function(rect) {
          context.strokeStyle = '#a64ceb';
          context.strokeRect(rect.x, rect.y, rect.width, rect.height);
          context.font = '11px Helvetica';
          context.fillStyle = "#fff";
          context.fillText('x: ' + rect.x + 'px', rect.x + rect.width + 5, rect.y + 11);
          context.fillText('y: ' + rect.y + 'px', rect.x + rect.width + 5, rect.y + 22);
        });
        scContext.drawImage(video,0,0,290,218);
    	var imgStr = shortCut.toDataURL("image/png");    
    	//var base64 = imgstr.split("base64,")[1];
    	//alert(111);
    	$.ajax({
    		url:"/Face_Recognition/servlet/LoginFace",
    		type:"post",
   			dataType:"json",
    		data:{img:imgStr.substring(imgStr.indexOf(",")+1)},
    		dataType: 'text',
			async: true,//异步
			timeout: 8000,
			error: function(){
				alert('操作错误,请与系统管理员联系!');
			},
			success: function(data){
			if($.trim(data) == "true"){
				$('.alert').html('识别成功，打卡完成').addClass('alert-success').show().delay(100).fadeOut();
				//alert("识别成功，打卡完成");
			}else{
				alert("面容识别失败,请继续验证");
			}
			}
		});
      });

    };
  </script>

</body>
</html>

