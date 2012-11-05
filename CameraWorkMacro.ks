;yu-ris�̂悤�ȃJ�����@�\��������}�N��
;TJS�ɒ���!�Ŕz�z���Ă���exmove.ks�����b�v���āA
;���ׂẴ��C���[�𓯂������A�����_�𒆐S�ɓ�����
;�ړ��A��], �g��k�������邱�ƂŎ������Ă��܂��B
;exmove.ks�̎g�p�̂��ߔw�i���C���ɂ͂����Ȃ��̂�
;�ꎞ�I�ɑO�i���C����w�i���C���Ƃ��Ďg�����ƂɂȂ�܂��B
;
;@camera_Init baselayer=0 messagelayer=1
;�ŏ��Ƀ��b�Z�[�W���C���̘g��\�����郌�C��(��������)�A
;�w�i�Ƃ��Ďg�����C�����w�肷��B
;�����Őݒ肵��baselayer��肨���������C���ԍ��̃��C���ɍ�p����B
;
;�g����^�O
;@camera cx=��΍��W cy=��΍��W angle=�X�� close=�{��(%) time=���� accel=�����x delay= opacity=(255) except=��O���C��
;cx,cy�Ŏw�肵���ʒu�Ɏ��_���ړ�����B
;close�Ŕ{���w�� 100�Œʏ�̑傫���A200�Ŕ{
;angle  cx, cy�Ŏw�肵���ʒu���S�ɉ�]����
;	angle��360�̐����{���w�肵�Ă͂����Ȃ��A
;	���̌�̉�]�����������Ȃ�B�g���Ă��������A
;	������@camera_reset�����邱��
;	��]���g������ʏ�̉�ʂɖ߂�����K��������
;	@camera_reset�����邱��
;
;	����!! (�o�O�����߂���̂ŉ�ʂ̒��S�ȊO����]���ɂ͂��Ȃ��ł�������)
;
;except �����Ŏw�肵�����C���ɂ͓��삵�Ȃ�
;
;@camera_wait
;@camera_move�̓����҂�
;
;@camera_reset
;�ϐ�������������B��]��A�^�C�g����ʂŎg��
;��]�@�\���g��Ȃ��Ȃ�A�K�v�Ȃ�

@iscript
var camera = %[];
f.CameraWorkMacro = %[];
function camera_Init(elm)
{
	f.CameraWorkMacro.pre_top      = %[];
	f.CameraWorkMacro.pre_left     = %[];
	camera.messagelayer = 'kara';
	camera.messagelayer = elm.messagelayer if elm.messagelayer !== void;
	camera.baselayer = elm.baselayer;
}
function camera_reset()
{
	f.CameraWorkMacro.pre_cx = void;
	f.CameraWorkMacro.pre_cy = void;
	(Dictionary.clear incontextof f.CameraWorkMacro.pre_top )();
	(Dictionary.clear incontextof f.CameraWorkMacro.pre_left)();
}
function camera_move(elm)
{
	elm.camerax = elm.cx;
	elm.cameray = elm.cy;
	elm.time = 500 if elm.time === void;
	elm.opacity = 255 if elm.opacity === void;
	for ( var i=(int) camera.baselayer; i<kag.numCharacterLayers; i++ )
	{
		if ( i != camera.messagelayer || i != elm.except)
		{
			elm.layer = (string)i;
			elm.path = '(' + ( kag.fore.layers[i].left + kag.scWidth/2 - elm.camerax ) + ', ' + ( kag.fore.layers[i].top + kag.scHeight/2 - elm.cameray ) + ', ' + elm.opacity + ')';
			kag.tagHandlers.move(elm);
		}
	}
}
function camera_exmove(elm)
{
	elm.close = 100 if elm.close === void;
	elm.angle = 0 if elm.angle === void;
	elm.opacity = 255 if elm.opacity === void;
	elm.time = 500 if elm.time === void;
	elm.except = 'kara' if elm.except === void;
	elm.layer = camera.baselayer;
	elm.cx = kag.scWidth/2 if elm.cx === void;
	elm.cy = kag.scHeight/2 if elm.cy === void;
	elm.camerax = elm.cx;
	elm.cameray = elm.cy;
	if (f.CameraWorkMacro.pre_angle == 0)
	{
		for ( var i=(int) camera.baselayer ; i<kag.numCharacterLayers; i++ )
		{
			if (i != camera.messagelayer && i != elm.except )
			{
				elm.layer = (string)i;
				elm.cx = (string)(elm.camerax - kag.fore.layers[i].left);
				elm.cy = (string)(elm.cameray - kag.fore.layers[i].top);
				elm.path = '(' + kag.scWidth/2 + ', ' + kag.scHeight/2 + ', ' + elm.opacity + ', ' + elm.close + ', ' + elm.angle + ')';
				ExtendedMover.beginMove(mp);
				
				f.CameraWorkMacro.pre_top[i]  = kag.fore.layers[i].top;
				f.CameraWorkMacro.pre_left[i] = kag.fore.layers[i].left;
				//Debug.message('path: ' + elm.path);
				//Debug.message('cx: ' + elm.cx);
				//Debug.message('cy: ' + elm.cy);
			}
		}
	}
	else
	{
		for ( var i=(int) camera.baselayer; i<kag.numCharacterLayers; i++ )
		{
			if (i != camera.messagelayer && i != elm.except)
			{
				//Debug.message(i);
				//Debug.message('pre_left: '+f.CameraWorkMacro.pre_left[i]);
				//Debug.message('pre_top: '+f.CameraWorkMacro.pre_top[i]);
				//Debug.message('pre_cx: '+f.CameraWorkMacro.pre_cx);
				//Debug.message('pre_cy: '+f.CameraWorkMacro.pre_cy);
				var r = Math.sqrt(Math.pow((f.CameraWorkMacro.pre_left[i] - f.CameraWorkMacro.pre_cx),2) + Math.pow((f.CameraWorkMacro.pre_top[i] - f.CameraWorkMacro.pre_cy),2));
				var angle  = f.CameraWorkMacro.pre_top[i] < f.CameraWorkMacro.pre_cy ? f.CameraWorkMacro.pre_angle*3.14159265/180 - Math.acos( 1 - (Math.pow(f.CameraWorkMacro.pre_left[i] - f.CameraWorkMacro.pre_cx - r,2) + Math.pow(f.CameraWorkMacro.pre_top[i] - f.CameraWorkMacro.pre_cy,2)) / ( 2*Math.pow(r,2) ) ) : (f.CameraWorkMacro.pre_angle - 360)*3.14159265/180 + Math.acos( 1 - (Math.pow(f.CameraWorkMacro.pre_left[i] - f.CameraWorkMacro.pre_cx - r,2) + Math.pow(f.CameraWorkMacro.pre_top[i] - f.CameraWorkMacro.pre_cy,2)) / ( 2*Math.pow(r,2) ) );
				var now_left = r*Math.cos(angle) + kag.scWidth/2;
				var now_top  = r*Math.sin(angle) + kag.scHeight/2;
				
				var a = 100;
				var b = Math.pow(now_left - elm.camerax,2) + Math.pow(now_top - elm.cameray,2);
				var c = Math.pow(now_left - (int)elm.camerax + 10,2) + Math.pow(now_top - (int)elm.cameray, 2);
				var angle2 = elm.cameray >= now_top ? Math.acos( (a + b - c)/(2*Math.sqrt(a*b)) ) - f.CameraWorkMacro.pre_angle*3.14159265/180 : ( 360 - f.CameraWorkMacro.pre_angle)*3.14159265/180 - Math.acos( (a + b - c)/(2*Math.sqrt(a*b)) );
				
				elm.cx = (string) (int) (Math.sqrt(b)*Math.cos(angle2));
				elm.cy = (string) (int) (Math.sqrt(b)*Math.sin(angle2));
				elm.path = '(' + kag.scWidth/2 + ', ' + kag.scHeight/2 + ', ' + elm.opacity + ', ' + elm.close + ', ' + elm.angle + ')';
				elm.layer = (string)i;
				//Debug.message(i);
				//Debug.message(elm.cameray);
				//Debug.message('r: ' + r);
				//Debug.message('angle: ' + angle*180/3.14);
				//Debug.message('left: ' + now_left);
				//Debug.message('top: ' + now_top);
				//Debug.message(a);
				//Debug.message(b);
				//Debug.message(c);
				//Debug.message('path: ' + elm.path);
				//Debug.message('cx: ' + elm.cx);
				//Debug.message('cy: ' + elm.cy);
				//Debug.message('angle2: ' + angle2*180/3.14);
				ExtendedMover.beginMove(mp);
				
				f.CameraWorkMacro.pre_top[i]  = now_left;
				f.CameraWorkMacro.pre_left[i] = now_top;
			}
		}
	}
	f.CameraWorkMacro.pre_cx = elm.camerax;
	f.CameraWorkMacro.pre_cy = elm.cameray;
	f.CameraWorkMacro.pre_angle = elm.angle;
}
@endscript

;�}�N���o�^
;������
@macro name=camera_Init
@eval exp="camera_Init(mp)"
@endmacro
;�J�����𓮂����B
@macro name=camera_move
@eval exp="camera_exmove(mp)" cond="mp.close !== void || mp.angle !== void"
@eval exp="camera_move(mp)" cond="mp.close === void"
@endmacro
;�E�F�C�g
@macro name=camera_wait
@call storage=CameraWorkMacro.ks target=*camera_wait
@endmacro
;�ϐ����Z�b�g
@macro name=camera_reset
@eval exp="camera_reset()"
@endmacro


@return

;�T�u���[�`��
*camera_wait
@wm
@eval exp="camera.count = camera.messagelayer === void ? (int)camera.baselayer + 1: (int)camera.baselayer + 2"
*step
@wm
@eval exp="camera.count += 1"
@jump storage="CameraWorkMacro.ks" target=*step cond="camera.count < kag.numCharacterLayers"
@return
