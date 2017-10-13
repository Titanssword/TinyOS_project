// $Id: BlinkToRadio.h,v 1.4 2006-12-12 18:22:52 vlahan Exp $

#ifndef SIMPLE_TRANSCEIVER_H
#define SIMPLE_TRANSCEIVER_H

enum {
  AM_SIMPLE_TRANSCEIVER = 6,
  //TIMER_PERIOD_MILLI = 250
};

typedef nx_struct simple_transceiver {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
} simple_transceiver_t;

#endif
