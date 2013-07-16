Maxim maxim = new Maxim(this);

class Notes {

  ArrayList<AudioPlayer> notes;

  String[] files = {
    "3f.wav", 
    "3g.wav", 
    "3a.wav", 
    "3b.wav", 
    "4c.wav", 
    "4d.wav", 
    "4e.wav", 
    "4f.wav", 
    "4g.wav", 
    "4a.wav", 
    "4b.wav", 
    "5c.wav", 
    "5d.wav", 
    "5e.wav", 
    "5f.wav", 
    "5g.wav",
  };

  Notes() {
    notes = new ArrayList<AudioPlayer>();
  }

  void draw() {
    // Play newly added note, because Maxim.js does not seem to be able to play immediately after creation of the note.
    if ( notes.size() > 0 ) notes.get(notes.size()-1).play();
    // Remove all older notes if they're not playing.
    for ( int i = 0; i < notes.size()-1; i++ ) {
      AudioPlayer note = notes.get(i);
    }
  }

  void play( int _index ) {
    String file = files[_index];
    AudioPlayer note = maxim.loadFile(file);
    //note.play();
    notes.add(note);
  }
}

