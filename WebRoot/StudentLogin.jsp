<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>人脸识别考勤系统</title>
	
    <style>
    	body {
			background: url("./images/bg1.jpg") no-repeat;
			background-size: 100% auto;
			background-attachment: fixed;
		}
		
        * {
            padding: 0;
            margin: 0;
        }

        .container {
            width: 600px;
			height: 400px;
			margin: 20px auto;
			position: relative;
			overflow: hidden;
        }

        .message{
        	float:left;
        }

        video, #canvas {
            position: absolute;
            width: 581px;
            height: 436px;
        }
       
		.successMsg {
			display: none;		
			color: green;		
			text-align: center;		
			position: fixed;	
			background-color: white;	
			font-size: 30px;	
			z-index: 9999;
			height: 400px;
			width: 400px;
			border-radius: 50%;
			line-height: 400px;
		}

    </style>
   	</head>
<body>
	<div id="successMsg" class="successMsg">
		识别成功，打卡完成
	</div>
	<div class="container">
	    <video id="video" preload autoplay loop muted></video>
	    <canvas id="canvas" width="581" height="436"></canvas>
	</div>
	<div class="message">
		<canvas id="shortCut" width="290" height="218" ></canvas>
		<div id="checkinMsg"></div>
	</div>
</body>
	<script src="./js/jquery-3.3.1.min.js"></script>	
	<script type="text/javascript" src="./js/tracking-min.js"></script>
	<script type="text/javascript" src="./js/face-min.js"></script>
    <script>
    
	    $(function () {
	        var video = document.getElementById('video');
	        var canvas = document.getElementById('canvas');
	        var context = canvas.getContext('2d');
	        var shortCut = document.getElementById('shortCut');
	        var scContext = shortCut.getContext('2d');
			var time = 3000;//向后台发照片的冷却时间
	        var tracker = new tracking.ObjectTracker('face');
	        
	        tracker.setInitialScale(4);
	        tracker.setStepSize(2);
	        tracker.setEdgesDensity(0.1);
	        tracking.track('#video', tracker, {camera: true});
	        
			var flag=true;
	        tracker.on('track', function (event) {
	        	if (event.data.length === 0) {
	        		context.clearRect(0, 0, canvas.width, canvas.height);
	        	}else{
	        		context.clearRect(0, 0, canvas.width, canvas.height);
	        		event.data.forEach(function (rect) {
		                context.strokeStyle = '#ff0000';
		                context.strokeRect(rect.x, rect.y, rect.width, rect.height);
		                context.fillStyle = "#ff0000";
		                //console.log(rect.x, rect.width, rect.y, rect.height);
		            });
	        		if(flag){
	        			console.log("拍照");
	        			getPhoto();
	        			flag=false;
	        			setTimeout(function(){flag=true;},time);
	        		}else{
	        			console.log("冷却中");
	        		}
	        	}
	        });

	        function getPhoto() {
	        	scContext.drawImage(video,0,0,290,218);
	        	var imgStr = shortCut.toDataURL("image/png");    
	        	//var base64 = imgstr.split("base64,")[1];
	        	//将拍照的图片数据发送到controller，调用百度云，签到，返回签到结果
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
						$("#successMsg").show(100).delay(1000).fadeOut(100);
						//alert("识别成功，打卡完成");
					}else{
						alert("面容识别失败,请继续验证");
					}
					}
				});
	      	}
	    });	
	        
	</script>	    


</html>
