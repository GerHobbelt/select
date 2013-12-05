init = ->
    setupDemo()

setupDemo = ->
    $button = $('.button.demo')

    positions = [
        'top left'
        'left top'
        'left bottom'
        'bottom left'
        'bottom right'
        'right bottom'
        'right top'
        'top right'
    ]

    window.drops = {}

    for position in positions
        drops[position] = new Drop
            target: $button[0]
            className: 'drop-theme-arrows'
            attach: position
            constrainToScrollParent: true
            trigger: 'manual' # Just not click
            content: $.map(position.split(' '), (word) -> word.substr(0, 1).toUpperCase() + word.substr(1)).join(' ')

        # TODO - remove once zbloom fixes
        drops[position].$drop.addClass "drop-attached-#{ position.replace(' ', '-')}"

    openIndex = 0
    frames = 0
    frameLengthMS = 6

    openAllDrops = ->
        for position, drop of drops
            drop.open()

        drops['top right'].close()
        drops['bottom left'].close()

    openNextDrop = ->
        for position, drop of drops
            drop.close()

        drops[positions[openIndex]].open()
        drops[positions[(openIndex + 4) % positions.length]].open()

        openIndex = (openIndex + 1) % positions.length

        if frames > 40
            return openAllDrops()

        frames += 1

        setTimeout openNextDrop, frameLengthMS * frames

    openNextDrop()

    # $(document).on 'dropopen closedrop', (event) ->
    #     log 'event', 'type', event.type, 'drop', event

init()