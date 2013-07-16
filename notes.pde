Maxim maxim = new Maxim(this);

class Notes {

  AudioPlayer[] notes;

  String[] files = {
    "3f.mp3", 
    "3g.mp3", 
    "3a.mp3", 
    "3b.mp3", 
    "4c.mp3", 
    "4d.mp3", 
    "4e.mp3", 
    "4f.mp3", 
    "4g.mp3", 
    "4a.mp3", 
    "4b.mp3", 
    "5c.mp3", 
    "5d.mp3", 
    "5e.mp3", 
    "5f.mp3", 
    "5g.mp3",
  };

  Notes() {
    notes = new AudioPlayer[files.length];
    for ( int i = 0; i < files.length; i++ ) {
       notes[i] = maxim.loadFile(files[i]); 
    }
  }

  void play( int _index ) {
    notes[_index].stop();
    notes[_index].cue(0);
    notes[_index].play();
  }
}

