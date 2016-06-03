package common.gavanna 
{
	import common.Common;
	import flash.display.Sprite;  
	import flash.display.Shape;  
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Graphics;

	/**
	 * ...
	 * @author Gospodin.Sorokin
	 */
	
	public class IronScreen extends Sprite  
	{  
		private var _color          :uint;  
		private var _minRadius     	:int;  
		private var _segmentsCount  :int;  
		private var _segmentLength	:int;
		private var _rotationSpeed  :int;  
		private var _timer			:Timer;
		private var _playing		:Boolean = false;
		private var _game 			:App;
		private var _err 			:int;
		private var _shape			:Shape = new Shape();
		
// ------------- public
		public function IronScreen(_game:App, $pColor:uint = 0x666666, $minRadius:int = 10, $segmentLength:int = 10, $segmentsCount:int = 12, $rotationSpeed:int = 50)  
		{  
			super();
			_color = $pColor;  
			_minRadius = $minRadius;  
			_segmentLength = $segmentLength;
			_segmentsCount = $segmentsCount;  
			_timer = new Timer($rotationSpeed);
			_timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			
			var g:Graphics = _shape.graphics;
			g.beginFill(0x000000, 1);
			g.drawRect(0, 0, 1300, 1300);
			g.endFill();
			_shape.x = -650;
			_shape.y = -650;
			_shape.alpha = 0.3;
			addChild(_shape);
			
			buildDisplay();  
			
			this._game = _game;
			_timer.start();
		}
		
		public function start():void
		{
			_timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			_timer.start();
		}
		public function stop():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimerHandler);
		}
		public function setBack(_alpha:int):void
		{
			_shape.alpha = _alpha;
		}
// ------------- private
		private function buildDisplay():void  
		{  
			for(var i:int = 0; i < _segmentsCount; i++)
			{
				var line:Shape = drawRoundedRect(_segmentLength, _segmentLength * 0.4, _segmentLength * 0.2, _color);
					line.x = _minRadius;
					line.y = - line.height / 2;
				var tempMc:Sprite = new Sprite();
					tempMc.addChild(line);
					tempMc.alpha = 0.3 + 0.7 * i / _segmentsCount;
					tempMc.rotation = 360 * i / _segmentsCount;
				addChild(tempMc);
			}
        }  
        private function onTimerHandler(e:TimerEvent):void  
        {  
            rotation += 360 / _segmentsCount;
			if (Common.screenProcessing == false) {
				this.visible = false;
				_shape.alpha = 0.3
				_err = 0;
			} else {
				this.visible = true;
				++_err;
				if (_err > 200) {
					Common.screenProcessing = false;
				}
			}
        }  
		private function drawRoundedRect($w:Number, $h:Number, $bevel:Number = 0, $color:uint = 0x000000, $alpha:Number = 1):Shape
		{
			var mc:Shape = new Shape();
				mc.graphics.beginFill($color, $alpha);
				mc.graphics.moveTo($w - $bevel, $h);              	// начинаем с нижнего правого угла до закруления
				mc.graphics.curveTo($w, $h, $w, $h - $bevel);       // закругляем вверх и вправо
				mc.graphics.lineTo($w, $bevel);                  	// рисуем прямую вверх до величины след скоса
				mc.graphics.curveTo($w, 0, $w - $bevel, 0);       	// закругляем вврех и влево
				mc.graphics.lineTo($bevel, 0);                  	// рисуем верхнюю лини. влево до след скоса
				mc.graphics.curveTo(0, 0, 0, $bevel);           	// рисуем верхний левый скос
				mc.graphics.lineTo(0, $h - $bevel);              	// рисуем левую сторону
				mc.graphics.curveTo(0, $h, $bevel, $h);           	// рисуем нижний левый скос
				mc.graphics.lineTo($w - $bevel, $h);              	// рисуем нижнюю линию
				mc.graphics.endFill();
			return mc;
		}
		
    }
	
}