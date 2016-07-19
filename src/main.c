#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "main.h"
#include "mp3.h"
#include "stm32f4xx_conf.h"

static void MP3_play_task(void *pvParameters);
xTaskHandle *pvLEDTask;

int main(void)
{
	/* Create a task to play music from micro USB. */
  	xTaskCreate(MP3_play_task,
             (signed portCHAR *) "Play music from micro USB",
             1024 /* stack size */, NULL,
             tskIDLE_PRIORITY + 5, NULL);

 	 vTaskStartScheduler();
  	return 0;
}
static void MP3_play_task(void *pvParameters)
{
	mp3_play();
	while(1);
}


void vApplicationTickHook()
{
}
