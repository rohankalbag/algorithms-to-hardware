#include <vhdlCStubs.h>
void global_storage_initializer_()
{
char buffer[4096];  char* ss;  sprintf(buffer, "call global_storage_initializer_ ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
uint8_t shift_and_subtract_div(uint8_t a,uint8_t b)
{
char buffer[4096];  char* ss;  sprintf(buffer, "call shift_and_subtract_div ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_uint8_t(buffer,a); ADD_SPACE__(buffer);
append_uint8_t(buffer,b); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,8); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint8_t quotient = get_uint8_t(buffer,&ss);
return(quotient);
}
