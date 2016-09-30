#!/usr/bin/env python
# CREATED:2016-02-11 12:07:58 by Brian McFee <brian.mcfee@nyu.edu>
"""Sonification tests"""

import numpy as np

from nose.tools import raises, eq_

from eval_test import create_hierarchy

import jams


@raises(jams.NamespaceError)
def test_no_sonify():

    ann = jams.Annotation(namespace='vector')
    jams.sonify.sonify(ann)


@raises(jams.SchemaError)
def test_bad_sonify():
    ann = jams.Annotation(namespace='chord')
    ann.append(time=0, duration=1, value='not a chord')

    jams.sonify.sonify(ann)


def test_duration():

    def __test(ns, duration, sr):
        ann = jams.Annotation(namespace=ns)
        ann.append(time=3, duration=1, value='C')

        y = jams.sonify.sonify(ann, sr=sr, duration=duration)

        if duration is not None:
            eq_(len(y), int(sr * duration))

    for ns in ['segment_open', 'chord']:
        for sr in [8000, 11025]:
            for dur in [None, 5.0, 10.0]:
                yield __test, ns, dur, sr


def test_note_hz():
    ann = jams.Annotation(namespace='note_hz')
    ann.append(time=0, duration=1, value=261.0)
    y = jams.sonify.sonify(ann, sr=8000, duration=2.0)

    eq_(len(y), 8000 * 2)


def test_note_hz_nolength():
    ann = jams.Annotation(namespace='note_hz')
    ann.append(time=0, duration=1, value=261.0)
    y = jams.sonify.sonify(ann, sr=8000)

    eq_(len(y), 8000 * 1)
    assert np.any(y)


def test_note_midi():
    ann = jams.Annotation(namespace='note_midi')
    ann.append(time=0, duration=1, value=60)
    y = jams.sonify.sonify(ann, sr=8000, duration=2.0)

    eq_(len(y), 8000 * 2)


def test_contour():
    ann = jams.Annotation(namespace='pitch_contour')

    duration = 5.0
    fs = 0.01
    # Generate a contour with deep vibrato and no voicing from 3s-4s
    times = np.linspace(0, duration, num=int(duration / fs))
    rate = 5
    vibrato = 220 + 20 * np.sin(2 * np.pi * times * rate)

    for t, v in zip(times, vibrato):
        ann.append(time=t, duration=fs, value={'frequency': v,
                                               'index': 0,
                                               'voiced': (t < 3 or t > 4)})

    def __test(ann, duration):
        y = jams.sonify.sonify(ann, sr=8000, duration=duration)
        if duration is not None:
            eq_(len(y), 8000 * duration)

    for duration in [None, 5.0, 10.0]:
        yield __test, ann, duration


def test_chord():

    def __test(namespace, value):
        ann = jams.Annotation(namespace=namespace)
        ann.append(time=0.5, duration=1.0, value=value)
        y = jams.sonify.sonify(ann, sr=8000, duration=2.0)

        eq_(len(y), 8000 * 2)

    yield __test, 'chord', 'C:maj/5'
    yield __test, 'chord_harte', 'C:maj/5'


def test_event():

    def __test(namespace, value):
        ann = jams.Annotation(namespace=namespace)
        ann.append(time=0.5, duration=0, value=value)
        y = jams.sonify.sonify(ann, sr=8000, duration=2.0)
        eq_(len(y), 8000 * 2)

    yield __test, 'beat', 1
    yield __test, 'segment_open', 'C'
    yield __test, 'onset', 1


def test_beat_position():

    def __test(ann, sr, duration):
        yout = jams.sonify.sonify(ann, sr=sr, duration=duration)
        if duration is not None:
            eq_(len(yout), int(duration * sr))

    ann = jams.Annotation(namespace='beat_position')

    for i, t in enumerate(np.arange(0, 10, 0.25)):
        ann.append(time=t, duration=0,
                   value=dict(position=1 + i % 4,
                              measure=1 + i // 4,
                              num_beats=4,
                              beat_units=4))

    for length in [None, 5, 15]:
        yield __test, ann, 8000, length


def test_multi_segment():
    ann = create_hierarchy(values=['AB', 'abac', 'xxyyxxzz'], duration=30)
    sr = 8000

    def __test(ann, duration):
        y = jams.sonify.sonify(ann, sr=sr, duration=duration)
        if duration:
            eq_(len(y), duration * sr)

    for duration in [None, 15, 30]:
        yield __test, ann, duration
