Pitch
-----

pitch_class
~~~~~~~~~~~
Pitch measurements in ``(tonic, pitch class)`` format.

    +-------+----------+---------------+------------+
    | time  | duration | value         | confidence |
    +=======+==========+===============+============+
    | [sec] | [sec]    | - tonic       | --         |
    |       |          | - pitch class |            |
    +-------+----------+---------------+------------+

Each ``value`` field is a structure containing a ``tonic`` (note string, e.g., ``"A#"`` or
``"D"``)
and a pitch class ``pitch`` as an integer scale degree.  The ``confidence`` field is unconstrained.


*Example*

    +-------+----------+------------------+------------+
    | time  | duration | value            | confidence |
    +=======+==========+==================+============+
    | 0.000 | 30.0     | - tonic: ``C``   | null       |
    |       |          | - pitch: 0       |            |
    +-------+----------+------------------+------------+
    | 0.000 | 30.0     | - tonic: ``C``   | null       |
    |       |          | - pitch: 4       |            |
    +-------+----------+------------------+------------+
    | 0.000 | 30.0     | - tonic: ``C``   | null       |
    |       |          | - pitch: 7       |            |
    +-------+----------+------------------+------------+
    | 30.00 | 35.0     | - tonic: ``G``   | null       |
    |       |          | - pitch: 0       |            |
    +-------+----------+------------------+------------+


pitch_hz
~~~~~~~~
Pitch measurements in Hertz (Hz). Pitch (a subjective sensation) is represented
as fundamental frequency (a physical quantity), a.k.a. "f0".

    +-------+----------+---------------+------------+
    | time  | duration | value         | confidence |
    +=======+==========+===============+============+
    | [sec] | --       | - number      | --         |
    +-------+----------+---------------+------------+

The ``time`` field represents the instantaneous time in which the pitch f0 was
estimated. By convention, this (usually) represents the center time of the
analysis frame. Note that this is different from pitch_midi and pitch_class,
where ``time`` represents the onset time. As a consequence, the ``duration``
field is undefined and should be ignored. The ``value`` field is a number
representing the f0 in Hz. By convention, values that are equal to or less than
zero are used to represent silence (no pitch). Some algorithms (e.g. melody
extraction algorithms that adhere to the MIREX convention) use negative f0
values to represent the algorithm's pitch estimate for frames where it thinks
there is no active pitch (e.g. no melody), to allow the independent evaluation
of pitch activation detection (a.k.a. "voicing detection") and pitch frequency 
estimation. The ``confidence`` field is unconstrained.

*Example*

    +-------+----------+---------------+------------+
    | time  | duration | value         | confidence |
    +=======+==========+===============+============+
    | 0.000 | 0.000    | 300.00        | null       |
    +-------+----------+---------------+------------+
    | 0.010 | 0.000    | 305.00        | null       |
    +-------+----------+---------------+------------+
    | 0.020 | 0.000    | 310.00        | null       |
    +-------+----------+---------------+------------+
    | 0.030 | 0.000    | 0.00          | null       |
    +-------+----------+---------------+------------+
    | 0.040 | 0.000    | -280.00       | null       |
    +-------+----------+---------------+------------+
    | 0.050 | 0.000    | -290.00       | null       |
    +-------+----------+---------------+------------+


pitch_midi
~~~~~~~~~~
Pitch measurements in (fractional) MIDI note number notation.

    ===== ======== ====== ==========
    time  duration value  confidence
    ===== ======== ====== ==========
    [sec] [sec]    number  --
    ===== ======== ====== ==========

The ``value`` field is a number representing the pitch in MIDI notation.
Numbers can be negative (for notes below ``C-1``) or fractional.

*Example*

    ===== ======== ===== ==========
    time  duration value confidence
    ===== ======== ===== ==========
    0.000 30.000   24    null
    0.000 30.000   43.02 null
    15.00 45.000   26    null
    ===== ======== ===== ==========

