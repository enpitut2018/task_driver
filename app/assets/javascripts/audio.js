window.AudioContext = window.AudioContext || window.webkitAudioContext;
let context = new AudioContext();

// Audio 用の buffer を読み込む
let getAudioBuffer = function(url, fn) {
	let req = new XMLHttpRequest();
	// array buffer を指定
	req.responseType = 'arraybuffer';
	req.onreadystatechange = function() {
		if (req.readyState === 4) {
			if (req.status === 0 || req.status === 200) {
				// array buffer を audio buffer に変換
				context.decodeAudioData(req.response, function(buffer) {
					// コールバックを実行
					fn(buffer);
				});
			}
		}
	};
	req.open('GET', url, true);
	req.send('');
};

// サウンドを再生
let playSound = function(buffer) {
	// source を作成
	let source = context.createBufferSource();
	// buffer をセット
	source.buffer = buffer;
	// context に connect
	source.connect(context.destination);
	// 再生
	source.start(0);
};

let audio_files = [
	'excellent.mp3',
	'gambarimasyou.mp3',
	'go.mp3',
	'kaishishimasu.mp3',
	'sugoisugoi.mp3',
	'yokudekimashita.mp3'
];

let random_audio = audio_files[Math.floor(Math.random() * audio_files.length)];

window.onload = getAudioBuffer('/audio/' + random_audio, function(buffer) {
	playSound(buffer);
});