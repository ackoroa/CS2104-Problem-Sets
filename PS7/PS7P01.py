# PS7P01 Arnold Christopher Koroa A0092101Y

# This source was developed using python 3.0. There are
# several syntax differences between python 2.7 and 3.0
# that will render this code unuseable in python 2.7

# To run the simulation, simply call the procedure main()

# This simulation system works by simulating a scheduler
# that schedules a variable number of processes running
# concurrently in a round-robin fashion.
#
# The Scheduler class represents the scheduler.
# A scheduler object needs to be initialized before running
# the scheduler and a global list of processes pList need to
# be defined and populated with the processes to be scheduled
# for the initialization to perform successfuly.
# After initialization, the schedule() method then need to be called
# for the scheduler to start running all the processes in pList
# until all processes in the list terminates
#
# Processes are represented by the Process class.
# An object of this class holds 3 important information:
# 1) the ID of the process it represents
# 2) the generator "task" that represents the operation
#    preformed by the process as shown in the question
# 3) the status of the process, which can either be
#    "ready", "blocked" or "terminated"
# A process object is initialized by passing its ID and the task
# generator to its constructor
#
# To ensure mutual exclusion during the interfering addition
# a semaphore is used. This semaphore "mutex" is represented
# by a Semaphore object that is initialized with the value 1
# The acquire() procedure of the semaphore will block the
# process if the semaphore value is 0 and puts the blocked
# process to the semaphore's waiting list.
# The release() operation will increase the semaphore's value and
# unblocks one process from the semaphore's waiting list

class Semaphore:
	def __init__(self, initVal):
		self.val = initVal
		self.waitList = []

	def acquire(self, pID):
		if(self.val>0):
			self.val = self.val - 1
                # block calling process if val <= 0
		else: 
			p = self.findProcess(pID)
			self.waitList.append(p)
			p.block()

	def release(self):
		self.val = self.val + 1

		# unblock one process from waitList if any
		if(len(self.waitList)>0):
			p = self.waitList.pop()
			p.unblock()

        # get process object from pList given its ID
	def findProcess(self, pID):
		for p in pList:
			if(p.id == pID):
				return p

class Process:
	def __init__(self, id, task):
		self.id = id # process id
		self.task = task # task generator
		self.status = "ready" # initialize status to ready to run

	def run(self):
		try:
			next(self.task)
		except StopIteration:
			self.terminate()

	def block(self):
		self.status = "blocked"

	def unblock(self):
		self.status = "ready"

	def terminate(self):
		self.status = "terminated"

class Scheduler:
	def __init__(self):
		self.nP = len(pList) # no of processes
		self.curP = -1 # current process running

	def schedule(self):
		while(1):
                        # get next process in pList
			self.curP = (self.curP+1) % self.nP
			p = pList[self.curP]

                        # if process is not blocked run it
			if(p.status == "ready"):
				p.run()
			# if process terminated, remove from pList
			elif(p.status == "terminated"):
				pList.remove(p)
				self.nP = self.nP-1
				self.curP = self.curP - 1 # corrects next process pointer

                        # no more process running, terminate scheduler
			if(self.nP == 0):
				break

mutex = Semaphore(1)
pList = []

def task1(x):
	mutex.acquire("t1") # pass in the process id to acquire
	yield
	reg = x[0]  # increment a shared variable
	yield       # simulate the non-atomicity of load and store operations
	reg = reg+1 # that would be observed in realistic hardware
	yield
	x[0] = reg
	yield
	mutex.release()
	yield

def task2(x):
	mutex.acquire("t2") # pass in the process id to acquire
	yield
	reg = x[0]  # increment a shared variable
	yield       # simulate the non-atomicity of load and store operations
	reg = reg+1 # that would be observed in realistic hardware
	yield
	x[0] = reg
	yield
	mutex.release()
	yield

def main():
	x = [0]

	pList.append(Process("t1",task1(x))) # add the process that runs task1 to pList
	pList.append(Process("t2",task2(x))) # add the process that runs task2 to pList

	Scheduler().schedule() # initialize and run scheduler

	print("x =",x[0])
