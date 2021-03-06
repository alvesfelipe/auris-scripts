# Auris-Script Setup

These Scripts were made to install all content files necessary to Run Auris Modules.

These Modules includes:

- Auris Controller
- Auris Server
- Auris Filters
- Auris Drivers
- Midi-Melody Generator


### Installation:

There are two main Scripts:

  - mainAuris_Setup - Create all folders and clone all Auris Modules Git Repositories
  - dependencies_Setup - Install all dependencies necessary to run Midi-Melody Generator and Auris-Files Generator


Which Install:

- FFMPEG
- Numpy
- Scipy
- Python-PIP
- Wheel
- Cython
- Pandas
- Functools32
- Distribute
- Librosa
- Scikits
- Flask
- PureData (FOR UBUNTU 14.04LTS OR LESS ONLY)


And includes other 5 dependencies files to be installed:

- JAMS
- libsamplerate - 0.1.8
- MIDIutil - 0.89
- Melodia - 1.0
- VAMP - 1.1.0


Give permission to *mainAuris_Setup* script:
```sh
$ chmod 755 mainAuris_Setup
```

Run setup bash:
```sh
$ ./mainAuris_Setup
```

Wait for Installation to be concluded.

PS: mainAuris_Setup Script will automatically call the last version of *dependencies_Setup* Script found in Auris-Script Git Repository.


### Make Run:

Now that everything is ready to run, go to Auris Controller folder.
```sh
$ cd ~/MUSIC_DEAF/music_for_deaf/auris-controller/
```

Make and run:
```
$ make
$ make run
```