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

#define len 1 //just take the first value of the LoadProfile file
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
double Ibus[len];

void create_filenames();
void initialize_values();
void read_files_data();
void calculate_Ibus();
void write_new_files();

double Voltages[55]={252.130710,\
					 252.111952,\
					 252.129579,\
					 252.080675,\
					 252.080431,\
					 252.111937,\
					 252.062254,\
					 252.060691,\
					 252.060459,\
					 252.060406,\
					 252.060399,\
					 252.060592,\
					 252.051370,\
					 252.052587,\
					 252.051492,\
					 252.050825,\
					 252.051108,\
					 252.021897,\
					 252.031331,\
					 252.025378,\
					 252.033973,\
					 252.025291,\
					 252.019734,\
					 252.024617,\
					 252.006213,\
					 252.013240,\
					 252.021191,\
					 252.020846,\
					 252.003394,\
					 252.006375,\
					 252.003322,\
					 252.010630,\
					 252.002326,\
					 252.010100,\
					 252.001930,\
					 252.001675,\
					 252.001558,\
					 252.007720,\
					 252.004014,\
					 252.003095,\
					 251.994721,\
					 252.003826,\
					 251.991898,\
					 252.012021,\
					 251.994789,\
					 252.004533,\
					 251.991935,\
					 252.004466,\
					 252.004128,\
					 251.988500,\
					 251.998599,\
					 251.989057,\
					 251.988325,\
					 251.998084,\
					 251.988983};

//___________________________________________________
int main()
{	
	//printf("start main\n");

	create_filenames();
	//printf("test mult:%lf\n",mult[0]);

	initialize_values();
	//printf("ready to read files\n");

	read_files_data();

	calculate_Ibus();
    

    //printf("min_mul[index:%d]:%f, max_mult[index:%d]:%f\n",min_index,min_mult,max_index,max_mult);
 	//printf("min total load time:%.2d:%.2d:%.2d\n",hour[min_index][0],min[min_index][0],sec[min_index][0]);
 	//printf("max total load time:%.2d:%.2d:%.2d\n",hour[max_index][0],min[max_index][0],sec[max_index][0]);

 	printf("Changed the LP's Time zone of the Initial_Load_profile_csv folder\nCreated files in Load_profile_case1 folder\n");
 	write_new_files();

return 0;
}
//________________________________________________________________




void write_new_files(){
	int f=0;
	for(f=0;f<Files;f++){
		/*/each file is created and
		the correct info is introduced to make 
		gridlab-d simulation afterwards with such files/*/
		FILE * myfile;

		//add folder path where files are saved
		//add type of file writed
		myfile= fopen("Ibus_test.txt", "w+");
    	
    	//printf("file was opened\n");
	    int i=0;
	    //fprintf(myfile,"time,mult\n");

	    //add date and time zone to the final string
	    //char date[1][100];
	    //strcpy(folder[0],"2000-01-01 ");
	    //char timezone[1][100];
	    //strcpy(folder[0]," EST");


	    for(i=0;i<55;i++){
	    	fprintf(myfile,"Ibus_load[%i]:%lf\n",i+1,Ibus[i]);
		}

		//printf("closing file\n");
    	fclose(myfile);
	}

}



void calculate_Ibus(){
	/*/make neccessary operations/*/
    int i=0;//
    for(i=0;i<55;i++){
    	Ibus[i]= (mult[0][i]*1000)/(3*Voltages[i]*0.95);
   	}
}


void read_files_data(){
	int f=0;
	for(f=0;f<Files;f++){
		/*/each file is opened and
		the correct info is taken to make 
		neccesary operations afterwards/*/
		FILE * myfile;

		/*/ add a folder path to search the 
		Load Profiles from which is the data obtained/*/
		char folder[1][100];
		strcpy(folder[0],"Initial_Load_profile_csv\\");

		/*/ add the type of file readed /*/
		myfile= fopen(strcat(strcat(folder[0],filename[f]),".csv"), "r+");
		//printf("opened Load_profile_%d\n",f+1);
    	
    	//Get rid of first line of file
        char buffer[100];
    	fgets(buffer, 100, myfile);
        //printf("%s",&buffer[0]);


	    int i=0;
	    fscanf(myfile,"%d:%d:%d,%lf\n",&hour[i][f],&min[i][f],&sec[i][f],&mult[i][f]);
	    //printf("input[%i]:%.2d:%.2d:%.2d,%f\n",i+1,hour[i][f],min[i][f],sec[i][f],mult[i][f]);

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
		Ibus[i]=0;
	}
}

void create_filenames(){
	//create input files names
	strcpy(filename[0],"Load_profile_1");
	strcpy(filename[1],"Load_profile_2");
	strcpy(filename[2],"Load_profile_3");
	strcpy(filename[3],"Load_profile_4");
	strcpy(filename[4],"Load_profile_5");
	strcpy(filename[5],"Load_profile_6");
	strcpy(filename[6],"Load_profile_7");
	strcpy(filename[7],"Load_profile_8");
	strcpy(filename[8],"Load_profile_9");
	strcpy(filename[9],"Load_profile_10");
	strcpy(filename[10],"Load_profile_11");
	strcpy(filename[11],"Load_profile_12");
	strcpy(filename[12],"Load_profile_13");
	strcpy(filename[13],"Load_profile_14");
	strcpy(filename[14],"Load_profile_15");
	strcpy(filename[15],"Load_profile_16");
	strcpy(filename[16],"Load_profile_17");
	strcpy(filename[17],"Load_profile_18");
	strcpy(filename[18],"Load_profile_19");
	strcpy(filename[19],"Load_profile_20");
	strcpy(filename[20],"Load_profile_21");
	strcpy(filename[21],"Load_profile_22");
	strcpy(filename[22],"Load_profile_23");
	strcpy(filename[23],"Load_profile_24");
	strcpy(filename[24],"Load_profile_25");
	strcpy(filename[25],"Load_profile_26");
	strcpy(filename[26],"Load_profile_27");
	strcpy(filename[27],"Load_profile_28");
	strcpy(filename[28],"Load_profile_29");
	strcpy(filename[29],"Load_profile_30");
	strcpy(filename[30],"Load_profile_31");
	strcpy(filename[31],"Load_profile_32");
	strcpy(filename[32],"Load_profile_33");
	strcpy(filename[33],"Load_profile_34");
	strcpy(filename[34],"Load_profile_35");
	strcpy(filename[35],"Load_profile_36");
	strcpy(filename[36],"Load_profile_37");
	strcpy(filename[37],"Load_profile_38");
	strcpy(filename[38],"Load_profile_39");
	strcpy(filename[39],"Load_profile_40");
	strcpy(filename[40],"Load_profile_41");
	strcpy(filename[41],"Load_profile_42");
	strcpy(filename[42],"Load_profile_43");
	strcpy(filename[43],"Load_profile_44");
	strcpy(filename[44],"Load_profile_45");
	strcpy(filename[45],"Load_profile_46");
	strcpy(filename[46],"Load_profile_47");
	strcpy(filename[47],"Load_profile_48");
	strcpy(filename[48],"Load_profile_49");
	strcpy(filename[49],"Load_profile_50");
	strcpy(filename[50],"Load_profile_51");
	strcpy(filename[51],"Load_profile_52");
	strcpy(filename[52],"Load_profile_53");
	strcpy(filename[53],"Load_profile_54");
	strcpy(filename[54],"Load_profile_55");
}