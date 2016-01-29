/*/
C script to modify Load profiles.
This program read info of Base case Load profiles,
calculate the total power of each simulation time,
determine the min and max power value in the whole simulation time, and finally
writes new Load profiles with 20 kW for 30 minutes after the times
of min and max power values.
/*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define len 1440
#define Files 55
#define Charger_power 20

//contain variables of each file
int hour[len][Files];
int min[len][Files];
int sec[len][Files];
double mult[len][Files];

//contain filenames max string 100
char filename[Files][100];

//save sum of all files mult value
double sum_mult[len];

//to find min and max load time
double max_mult=0;
double min_mult=100;
int min_index=0;
int max_index=0;

void create_filenames();
void initialize_values();
void read_files_data();
void find_max_and_min_load_time();
void write_new_files();
void change_mult_values();
//___________________________________________________
int main()
{	
	//printf("start main\n");

	create_filenames();
	//printf("test mult:%lf\n",mult[0]);

	initialize_values();
	//printf("ready to read files\n");

	read_files_data();

	find_max_and_min_load_time();
    

    printf("min_mul[index:%d]:%f, max_mult[index:%d]:%f\n",min_index,min_mult,max_index,max_mult);
 	printf("min total load time:%.2d:%.2d:%.2d\n",hour[min_index][0],min[min_index][0],sec[min_index][0]);
 	printf("max total load time:%.2d:%.2d:%.2d\n",hour[max_index][0],min[max_index][0],sec[max_index][0]);

 	change_mult_values();

 	write_new_files();

return 0;
}
//________________________________________________________________



void change_mult_values(){
	int i=0;//for inputs
	int j=0;//for files
	for(j=0;j<Files;j++){
		for(i=min_index;i<(min_index+30);i++){
			mult[i][j]=20;
		}
		for(i=max_index;i<(max_index+30);i++){
			mult[i][j]=20;
		}
	}
}


void write_new_files(){
	int f=0;
	for(f=0;f<Files;f++){
		/*/each file is created and
		the correct info is introduced to make 
		gridlab-d simulation afterwards with such files/*/
		FILE * myfile;

		//add folder path where files are saved
		char folder[1][100];
		strcpy(folder[0],"Load_profile_20kW\\");
		myfile= fopen(strcat(folder[0],filename[f]), "w+");
    	
    	//printf("file was opened\n");
	    int i=0;
	    fprintf(myfile,"time,mult\n");
	    for(i=0;i<len;i++){
	    	fprintf(myfile,"%.2d:%.2d:%.2d,%lf\n",hour[i][f],min[i][f],sec[i][f],mult[i][f]);
	    	//printf("input[%i]:%.2d:%.2d:%.2d,%f\n",i+1,hour[i][f],min[i][f],sec[i][f],mult[i][f]);
		}

		//printf("closing file\n");
    	fclose(myfile);
	}

}



void find_max_and_min_load_time(){
	/*/make neccessary operations/*/
    int j=0;//for files
    int i=0;//for minute sample
    for(j=0;j<Files;j++){
    	for(i=0;i<len;i++){
	    	sum_mult[i]+= mult[i][j];
    	}
    }
    
    i=0;
    for(i=0;i<len;i++){
    	if(sum_mult[i]>=max_mult){
    		max_mult=sum_mult[i];
    		max_index=i;
    	}
    	if(sum_mult[i]<=min_mult){
    		min_mult=sum_mult[i];
    		min_index=i;
    	}
    }
}


void read_files_data(){
	int f=0;
	for(f=0;f<Files;f++){
		/*/each file is opened and
		the correct info is taken to make 
		neccesary operations afterwards/*/
		FILE * myfile;

		myfile= fopen(filename[f], "r+");
		//printf("opened Load_profile_%d\n",f+1);
    	
    	//Get rid of first line of file
        char buffer[100];
    	fgets(buffer, 100, myfile);
        //printf("%s",&buffer[0]);


	    int i=0;
	    for(i=0;i<len;i++){
	    	fscanf(myfile,"%d:%d:%d,%lf\n",&hour[i][f],&min[i][f],&sec[i][f],&mult[i][f]);
	    	//printf("input[%i]:%.2d:%.2d:%.2d,%f\n",i+1,hour[i][f],min[i][f],sec[i][f],mult[i][f]);
		}

    	fclose(myfile);
    }
}


void initialize_values(){
	int i=0;
	int j=0;
	for(j=0;j<Files;j++){
		for(i=0;i<len;i++){
			hour[i][j]=0;
			min[i][j]=0;
			sec[i][j]=0;
			mult[i][j]=0;
		}
	}
	
	i=0;
	for(i=0;i<len;i++){
		sum_mult[i]=0;
	}
}

void create_filenames(){
	//create input files names
	strcpy(filename[0],"Load_profile_1.csv");
	strcpy(filename[1],"Load_profile_2.csv");
	strcpy(filename[2],"Load_profile_3.csv");
	strcpy(filename[3],"Load_profile_4.csv");
	strcpy(filename[4],"Load_profile_5.csv");
	strcpy(filename[5],"Load_profile_6.csv");
	strcpy(filename[6],"Load_profile_7.csv");
	strcpy(filename[7],"Load_profile_8.csv");
	strcpy(filename[8],"Load_profile_9.csv");
	strcpy(filename[9],"Load_profile_10.csv");
	strcpy(filename[10],"Load_profile_11.csv");
	strcpy(filename[11],"Load_profile_12.csv");
	strcpy(filename[12],"Load_profile_13.csv");
	strcpy(filename[13],"Load_profile_14.csv");
	strcpy(filename[14],"Load_profile_15.csv");
	strcpy(filename[15],"Load_profile_16.csv");
	strcpy(filename[16],"Load_profile_17.csv");
	strcpy(filename[17],"Load_profile_18.csv");
	strcpy(filename[18],"Load_profile_19.csv");
	strcpy(filename[19],"Load_profile_20.csv");
	strcpy(filename[20],"Load_profile_21.csv");
	strcpy(filename[21],"Load_profile_22.csv");
	strcpy(filename[22],"Load_profile_23.csv");
	strcpy(filename[23],"Load_profile_24.csv");
	strcpy(filename[24],"Load_profile_25.csv");
	strcpy(filename[25],"Load_profile_26.csv");
	strcpy(filename[26],"Load_profile_27.csv");
	strcpy(filename[27],"Load_profile_28.csv");
	strcpy(filename[28],"Load_profile_29.csv");
	strcpy(filename[29],"Load_profile_30.csv");
	strcpy(filename[30],"Load_profile_31.csv");
	strcpy(filename[31],"Load_profile_32.csv");
	strcpy(filename[32],"Load_profile_33.csv");
	strcpy(filename[33],"Load_profile_34.csv");
	strcpy(filename[34],"Load_profile_35.csv");
	strcpy(filename[35],"Load_profile_36.csv");
	strcpy(filename[36],"Load_profile_37.csv");
	strcpy(filename[37],"Load_profile_38.csv");
	strcpy(filename[38],"Load_profile_39.csv");
	strcpy(filename[39],"Load_profile_40.csv");
	strcpy(filename[40],"Load_profile_41.csv");
	strcpy(filename[41],"Load_profile_42.csv");
	strcpy(filename[42],"Load_profile_43.csv");
	strcpy(filename[43],"Load_profile_44.csv");
	strcpy(filename[44],"Load_profile_45.csv");
	strcpy(filename[45],"Load_profile_46.csv");
	strcpy(filename[46],"Load_profile_47.csv");
	strcpy(filename[47],"Load_profile_48.csv");
	strcpy(filename[48],"Load_profile_49.csv");
	strcpy(filename[49],"Load_profile_50.csv");
	strcpy(filename[50],"Load_profile_51.csv");
	strcpy(filename[51],"Load_profile_52.csv");
	strcpy(filename[52],"Load_profile_53.csv");
	strcpy(filename[53],"Load_profile_54.csv");
	strcpy(filename[54],"Load_profile_55.csv");
}