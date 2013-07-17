// Loads and plays the notes.

Maxim maxim = new Maxim(this);

class Notes {

  AudioPlayer[] notes;

  Notes() {
    // Load ALL the samples!
    notes = new AudioPlayer[SAMPLES.length];
    for ( int i = 0; i < SAMPLES.length; i++ ) {
       notes[i] = maxim.loadFile(SAMPLES[i]); 
    }
  }

  void play( int _index ) {
    // In order to replay a note it has to be stopped, rewound, and then played again.
    notes[_index].stop();
    notes[_index].cue(0);
    notes[_index].play();
  }
}

