#include <vhdlCStubs.h>
void global_storage_initializer_()
{
char buffer[4096];  char* ss;  sprintf(buffer, "call global_storage_initializer_ ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
uint16_t shift_and_add_mul(uint8_t a,uint8_t b)
{
char buffer[4096];  char* ss;  sprintf(buffer, "call shift_and_add_mul ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_uint8_t(buffer,a); ADD_SPACE__(buffer);
append_uint8_t(buffer,b); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,16); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint16_t product = get_uint16_t(buffer,&ss);
return(product);
}
