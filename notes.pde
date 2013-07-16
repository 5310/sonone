Maxim maxim = new Maxim(this);

class Notes {

  ArrayList<AudioPlayer> notes;

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

