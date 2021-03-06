-- Animation file descriptor
-- This file will describe the frames used to load an animation

animation = {

    -- The file to load the frames from
    image_filename = "img/sprites/battle/enemies/fenrir.png",
    -- The number of rows and columns of images, will be used to compute
    -- the images width and height, and also the frames number (row x col)
    rows = 1,
    columns = 4,
    -- set the image dimensions on battles (in pixels)
    frame_width = 469.0,
    frame_height = 297.0,
    -- The frames duration in milliseconds
    frames = {
        [0] = { id = 1, duration = 999999 },
    }
    }
