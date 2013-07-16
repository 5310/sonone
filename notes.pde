Maxim maxim = new Maxim(this);

class Notes {

  AudioPlayer[] notes;

  Notes() {
    notes = new AudioPlayer[SAMPLES.length];
    for ( int i = 0; i < SAMPLES.length; i++ ) {
       notes[i] = maxim.loadFile(SAMPLES[i]); 
    }
  }

  void play( int _index ) {
    notes[_index].stop();
    notes[_index].cue(0);
    notes[_index].play();
    //println(SAMPLES[_index]);
  }
}

