Config = {
    Locale = 'en',

    Controls = {
        -- FiveM Controls: https://docs.fivem.net/game-references/controls/
        openKey = 214, -- CANC
        goUp = 85, -- Q
        goDown = 48, -- Z
        turnLeft = 34, -- A
        turnRight = 35, -- D
        goForward = 32,  -- W
        goBackward = 33, -- S
        changeSpeed = 21, -- L-Shift
        camMode = 74, -- H
    },

    Speeds = {
        -- You can add or edit existing speeds with relative label
        { label = 'Very Slow', speed = 0},
        { label = 'Slow', speed = 0.5},
        { label = 'Normal', speed = 2},
        { label = 'Fast', speed = 5},
        { label = 'Very Fast', speed = 10},
        { label = 'Max', speed = 15},
    },

    Offsets = {
        y = 0.5, -- Forward and backward movement speed multiplier
        z = 0.2, -- Upward and downward movement speed multiplier
        h = 3, -- Rotation movement speed multiplier
    },

    FrozenPosition = false, -- Toggle "frozen" position for noclipping player
}