#include < iostream>
class Staff
{
	char * name;
	char * job;
public:
	Staff(char * sName, char * sJob)
	{
		setJob(sJob);
		setName(sName);
	}
	void setJob(char *sJob)
	{
		job = sJob;
	}
	void setName(char * sName)
	{
		name = sName;
	}
	char * getName()
	{
		return name;
	}
	char * getJob()
	{
		return job;
	}
};
