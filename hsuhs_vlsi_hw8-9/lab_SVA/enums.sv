enum logic[3:0] {
    IDLE = 0,
    CHECK_CACHE = 1,
    READ_MEM = 2,
    HIT = 3,
    MISS = 4,
    READ_CACHE = 5
  } ps,ns;
