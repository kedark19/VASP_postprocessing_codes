#!/usr/bin/python3
###  Kedar
import matplotlib.pyplot as plt
    import numpy as np
    import matplotlib.image as image
    from matplotlib.offsetbox import  OffsetImage


    fig=plt.figure(figsize=(12,9))
    ax=fig.add_subplot(111)

    npts=2001
    ymin=-8
    ymax=8
    xmin=-3.5
    xmax=3.5


    with open('TDOS.dat') as f:
        lines_b=f.readlines()
    with open('PDOS_USER.dat') as f1:
        lines_b1=f1.readlines()  
        
    B_U=np.zeros(npts)    
    B_D=np.zeros(npts) 
    energy_b=np.zeros(npts) 
    B_M=np.zeros((npts,8))

    for j in np.arange(npts):
        energy_b[j]=lines_b[j+1].split()[0]
        
    for j in np.arange(npts):
        energy_b[j]=lines_b[j+1].split()[0]
        B_U[j]=lines_b[j+1].split()[1]
        B_D[j]=lines_b[j+1].split()[2]

    ax.fill_between(energy_b,B_U/8,color='black', alpha=0.3,label='Total')
    ax.fill_between(energy_b,B_D/8,color='black', alpha=0.3)

    for j in np.arange(npts):
        B_M[j,0]=lines_b1[j+1].split()[1]
        B_M[j,1]=lines_b1[j+1].split()[2]
        B_M[j,2]=lines_b1[j+1].split()[3]
        B_M[j,3]=lines_b1[j+1].split()[4]
        B_M[j,4]=lines_b1[j+1].split()[5]
        B_M[j,5]=lines_b1[j+1].split()[6]
        B_M[j,6]=lines_b1[j+1].split()[7]
        B_M[j,7]=lines_b1[j+1].split()[8]
        
    ax.plot(energy_b,B_M[:,0]/8,color='b', linewidth=2.6,label='Co')
    ax.plot(energy_b,B_M[:,1]/8,color='b', linewidth=2.6)
    ax.plot(energy_b,B_M[:,2]/8,color='r', linewidth=2.6,label='Fe(Oh)')
    ax.plot(energy_b,B_M[:,3]/8,color='r', linewidth=2.6)
    ax.plot(energy_b,B_M[:,4]/8,color='g', linewidth=2.6,label='Fe(Td)')
    ax.plot(energy_b,B_M[:,5]/8,color='g', linewidth=2.6)
    ax.plot(energy_b,B_M[:,6]/8,color='purple', linewidth=2.6,label='O')
    ax.plot(energy_b,B_M[:,7]/8,color='purple', linewidth=2.6)
        

    plt.yticks(np.arange(ymin, ymax, 2))
    plt.xticks(np.arange(xmin+0.5, xmax, 1))
    plt.xlim(xmin, xmax)
    plt.ylim(ymin, ymax)
    ax.axhline(y=0.0, xmin=xmin, xmax=xmax,linestyle='dashed', linewidth=1, color = 'k')
    ax.vlines(x=0.0, ymin=ymin, ymax=ymax,linestyles='dashed', linewidth=1, color = 'k')
        
    plt.ylabel("DOS (states/eV)",size=32)
    ax.tick_params(axis='both', which='major',direction='in',length=5, bottom=True, top=True, right=True, left=True, labelbottom=False)
        
    ax.tick_params(axis = 'both', which = 'major', labelsize = 28, width=2)
    ax.spines['top'].set_linewidth(2)
    ax.spines['right'].set_linewidth(2)
    ax.spines['left'].set_linewidth(2)
    ax.spines['bottom'].set_linewidth(2)

    #ax.text(xmax-0.8,ymax-5,"Bulk",size=15)
    plt.xlabel("Energy (eV)",size=32)
    ax.tick_params(axis='x', which='both', bottom=True, top=True, right=True, left=True, labelbottom=True)

    leg=ax.legend(fontsize=32,loc='upper center',framealpha=0.5, \
                       handlelength=1.5, handletextpad=0.2, markerscale=50, \
                       frameon=True, mode = 20, labelspacing=0.01, \
                        bbox_to_anchor=(0.135, 0.025,1.,1.0))

    plt.savefig("PDOS.pdf",bbox_inches='tight')

    #plt.show()
