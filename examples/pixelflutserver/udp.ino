extern "C" {
  #include "user_interface.h"
  #include "lwip/opt.h"
  #include "lwip/inet.h"
  #include "lwip/udp.h"
  #include "lwip/igmp.h"
  #include "lwip/init.h"
}

#ifndef UDP_VIDEO_PORT
#define UDP_VIDEO_PORT 1337
#endif



udp_pcb * pcb = udp_new();
int init_upd_video(uint8_t * fbuff) {
  if(pcb == NULL) return -1;

  udp_bind(pcb, INADDR_ANY, UDP_VIDEO_PORT);
  udp_recv(pcb, &udp_video_handler, fbuff);

  return 0;
}

int i = 0;
long last = millis();
float avrg_time = 0;


void udp_video_handler(void * fbuff, udp_pcb * pcb, pbuf * buf, struct ip_addr * addr, uint16_t port) {
  while(buf != NULL) {
    uint16_t len = buf->len;
    uint8_t * data = (uint8_t *)((buf)->payload);
    pbuf * this_pb = buf;

    buf = buf->next;
    this_pb->next = NULL;

    uint16_t pos = ((uint16_t *) data)[0];
    memcpy(fbuff + pos, &(((uint8_t *) data)[2]), len - 2);
    i+=len;
    if(i > 32768) {
      long now = millis();
      avrg_time =(now - last);
      Serial.println(avrg_time);
      char r = (avrg_time - 40);
      char g = 255 - (avrg_time - 40);
      last = now;
      pixels.setPixelColor(0, pixels.Color(r / 16, g / 16, 0));
      pixels.show();
      tft.writeFramebuffer();
      i = 0;


      uint16_t joy = analogRead(A0);
      uint16_t knob = digitalRead(16);
      udp_connect(pcb, INADDR_ANY, port);
      pbuf* pbt = pbuf_alloc(PBUF_TRANSPORT, 4, PBUF_RAM);
      if(pbt != NULL) {
          uint8_t* dst = reinterpret_cast<uint8_t*>(pbt->payload);
          memcpy(dst, &joy, 2);
          memcpy(dst + 2, &knob, 2);
          err_t err = udp_sendto(pcb, pbt, addr, 1337);
          pbuf_free(pbt);
      }
    }

    pbuf_free(this_pb);
    delay(20);
  }
}


