# Device detection

getMobileOperatingSystem = () ->
	userAgent = navigator.userAgent || navigator.vendor || window.opera
	if (/android/i.test(userAgent)) || Framer.Device.deviceType.search("google") >= 0 || Framer.Device.deviceType.search("htc") >= 0 || Framer.Device.deviceType.search("samsung") >= 0
		return "Android"
	if ((/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream)) || (Framer.Device.deviceType.search("apple") >= 0)
		return "iOS"
	return "unknown"


getMobileType = () ->
	switch getMobileOperatingSystem()
		when "iOS"
			if (Screen.height == 812) || (Framer.Device.deviceType.search("apple-iphone-x") >= 0)
				return "iphone-x"
			else
				return "classic-iphone"
		when "Android" then return "android"

getAllChildrenOfLayer = (layer, mem = []) ->
	allChildren = mem
	for child in layer.children
		if(child.children.length == 0)
			allChildren.push(child)
		else
			allChildren = allChildren.concat(child).concat(getAllChildrenOfLayer(child))		
	return allChildren			

#Status Bar Class
class StatusBar
	constructor : (@options = {}) ->
		#Layers
		@statusBarLayer = new Layer
			name: "statusBarLayer"
			y: 0
			midX: Screen.midX
			width: Screen.width
			backgroundColor: null
			parent: null
		#Update at creation	
		@changeStatusBar(getMobileType())		
	changeStatusBar : (phone) ->
		switch phone
			when "classic-iphone" then this.iPhoneStatusBar()
			when "iphone-x" then this.iPhoneXStatusbar()
			when "android" then this.androidStatusbar()
	iPhoneStatusBar : () ->
		@statusBarLayer.props = 
			height : 20
		hour = new TextLayer
			name: "hour"
			parent : @statusBarLayer
			text: "9:41 AM"
			fontSize: 12
			textAlign: "center"
			fontWeight: 600
			fontFamily: "-apple-system"
			color: "white"
			x: Align.center
			y: Align.center
		battery = new Layer
			name : "battery"
			parent: @statusBarLayer
			x: Align.right
			height: @statusBarLayer.height
			backgroundColor: null
		battery_icon = new Layer
			name : "battery_icon"
			parent: battery
			image: "./images/statusBarBattery.svg"
			invert: 100
			width: 25
			height: 10
			x: Align.right(-7)
			y: Align.center
		
		batteryPercent = new TextLayer
			parent : battery
			text: "100%"
			fontSize: 12
			textAlign: "center"
			fontWeight: 500
			fontFamily: "-apple-system"
			color: "white"
			x: Align.right(-battery_icon.width - 10)
			y: Align.center
		
		statusIcons = new Layer
			parent: @statusBarLayer
			x: Align.left
			height: @statusBarLayer.height
			backgroundColor: null
		
		signal = new Layer
			parent: statusIcons
			image: "./images/statusBarSignal.svg"
			invert: 100
			width: 15
			height: 10
			y: Align.center
			x: 7
		
		wifi = new Layer
			parent: statusIcons
			image: "./images/statusBarWifi.svg"
			invert: 100
			width: 14
			height: 10
			y: Align.center
			x: signal.x + signal.width + 3	
	iPhoneXStatusbar : () ->
		@statusBarLayer.props =
			y: 0
			midX: Screen.midX
			width: Screen.width
			height: 44
			backgroundColor: null
			parent: null
		hourFrame = new Layer
			parent: @statusBarLayer
			height: 16
			width: 54
			x: Align.left(21)
			y: Align.center
			backgroundColor: null
		
		hour = new TextLayer
			parent : hourFrame
			text: "9:41"
			fontSize: 14
			letterSpacing: -0.28
			textAlign: "center"
			fontWeight: 600
			fontFamily: "-apple-system"
			color: "white"
			x: Align.center
			y: Align.center
		
		statusIcons = new Layer
			parent: @statusBarLayer
			x: Align.right
			height: @statusBarLayer.height
			backgroundColor: null
		
		battery_icon = new Layer
			parent: statusIcons
			image: "./images/statusBarBattery.svg"
			invert: 100
			width: 25
			height: 10
			x: Align.right(-12)
			y: Align.center
		
		wifi = new Layer
			parent: statusIcons
			image: "./images/statusBarWifi.svg"
			invert: 100
			width: 14
			height: 10
			x: Align.right(-battery_icon.width - 12 - 5)
			y: Align.center
		
		signal = new Layer
			parent: statusIcons
			image: "./images/statusBarSignal.svg"
			invert: 100
			width: 15
			height: 10
			x: Align.right(-battery_icon.width - 12 - 5 - wifi.width - 5)
			y: Align.center
	androidStatusbar : () ->
		@statusBarLayer.props =
			y: 0
			midX: Screen.midX
			width: Screen.width
			height: 24
			backgroundColor: null
			parent: null
		
		hour = new TextLayer
			parent : @statusBarLayer
			text: "12:30"
			fontSize: 14
			textAlign: "right"
			fontWeight: 500
			fontFamily: "Roboto"
			color: "white"
			x: Align.right(-8)
			y: Align.center
		
		battery_icon = new Layer
			parent: @statusBarLayer
			image: "./images/android_statusBarBattery.svg"
			width: 9
			height: 14
			invert: 100
			x: Align.right(-hour.width - 8 - 7)
			y: Align.center
		
		signal = new Layer
			parent: @statusBarLayer
			image: "./images/android_statusBarSignal.svg"
			invert: 100
			width: 14
			height: 14
			x: Align.right(-hour.width - 8 - battery_icon.width - 7 - 9)
			y: Align.center
	
		wifi = new Layer
			parent: @statusBarLayer
			image: "./images/android_statusBarWifi.svg"
			invert: 100
			width: 18
			height: 14
			x: Align.right(-hour.width - 8 - battery_icon.width - 7 - 9 - signal.width - 2)
			y: Align.center
	hide : () ->
		@statusBarLayer.animate
			y: -@statusBarLayer.height
			options: 
				time: .4
				curve: Bezier.ease
	show : () ->
		@statusBarLayer.animate
			y: 0
			options: 
				time: .4
				curve: Bezier.ease
	light : () ->
		@statusBarLayer.invert = 0
	dark : () ->
		@statusBarLayer.invert = 100	
	destroyLayersInStatusBar : () ->
		for child in getAllChildrenOfLayer(@statusBarLayer)
			child.destroy()
	destroy : () ->	
		@destroyLayersInStatusBar()
		@statusBarLayer.destroy()
		