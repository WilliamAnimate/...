#!/bin/sh

# FIXME: these variable names are misleading
BLANK='#11111b00'
CLEAR='#cdd6f422'
DEFAULT='#f5c2e7E6'
TEXT='#cdd6f4E6'
WRONG='#f38ba8'
VERIFYING='#f5c2e7E6'
WHAT='#cdd6f4'

swaylock \
    --screenshots \
    --clock \
    --indicator \
    --indicator-radius 100 \
    --indicator-thickness 7 \
    --effect-blur 7x5 \
    --effect-vignette 0.5:0.5 \
    --ring-color $BLANK \
    --key-hl-color $DEFAULT \
    --line-color $DEFAULT \
    --inside-color $BLANK \
    --separator-color $WRONG \
    --text-wrong-color $WRONG \
    --text-color $TEXT \
    --ring-ver-color $VERIFYING \
    --inside-ver-color $VERIFYING \
    --inside-wrong-color $WRONG \
    --text-wrong-color $WHAT \
    --ring-wrong-color $WRONG \
    --grace 2 \
    --fade-in 0.1 \
