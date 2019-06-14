import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multiprocessing import Pool 

df=pd.read_csv('C:/Users/minhcq/Documents/safety/model_df.csv')

df['acceleration']=np.sqrt(df['acceleration_x']**2 + df['acceleration_y']**2 + df['acceleration_z']**2)
df['gyro']=np.sqrt(df['gyro_x']**2 + df['gyro_y']**2 + df['gyro_z']**2)

mobile_df = df[['acceleration_x','acceleration_y','acceleration_z','gyro_x','gyro_y','gyro_z']]
from sklearn.cluster import KMeans
km = KMeans()
km.fit(mobile_df.sample(30000))
df['mobile_group'] = km.predict(df[['acceleration_x','acceleration_y','acceleration_z','gyro_x','gyro_y','gyro_z']])
model_df = pd.DataFrame(columns=['triptime','Accuracy','DangerousBearingRatio','DangerousDeAccRatio','Stay_in_lane_Ratio','minspeed','meanspeed','sd_speed','25_quan_speed','50_quan_speed','75_quan_speed','ratio_above_90per','max_speed','ratio_at_0','ratio_at_25per','ratio_below_50per','ratio_above_50per','ratio_at_75per','ratio_at_maxspeed','mobile_type'])

def summerize(id,plot=0):
    id_data = df[df['bookingID'] == id]
    id_data.sort_values('second',inplace=True)
    triptime = id_data['second'].max()
    Accuracy = id_data['Accuracy'].mean()
    DangerousBearingRatio = id_data[(abs(id_data['Bearing'].diff())>20) & (abs(id_data['Bearing'].diff())<340)]['second'].count()/triptime
    DangerousDeAccRatio = id_data[id_data['Speed'].diff()<-5]['second'].count()/triptime
    Stay_in_lane_Ratio = id_data[(id_data['Speed'] > 0) & (id_data['Bearing'].diff()<10)]['second'].count()/triptime
    minspeed = id_data['Speed'].min()
    meanspeed = id_data['Speed'].mean()
    ratio_at_0 = id_data[id_data['Speed'] == 0]['second'].count()/triptime
    sd_speed = id_data['Speed'].std()
    t25_quan_speed = id_data['Speed'].quantile(0.25)
    t50_quan_speed = id_data['Speed'].quantile(0.5)                        
    t75_quan_speed = id_data['Speed'].quantile(0.75)
    t90_quan_speed = id_data['Speed'].quantile(0.90)
    ratio_at_25per = id_data[id_data['Speed']<t25_quan_speed]['second'].count()/triptime
    ratio_below_50per = id_data[id_data['Speed'].isin([t25_quan_speed,t50_quan_speed])]['second'].count()/triptime
    ratio_above_50per = id_data[id_data['Speed'].isin([t50_quan_speed,t75_quan_speed])]['second'].count()/triptime
    ratio_above_75per = id_data[id_data['Speed'].isin([t75_quan_speed,t90_quan_speed])]['second'].count()/triptime
    ratio_above_90per = id_data[id_data['Speed']>t90_quan_speed]['second'].count()/triptime
    max_speed = id_data['Speed'].max()
    ratio_at_maxspeed = id_data[id_data['Speed'] == max_speed]['second'].count()/triptime
    mobile_type = id_data['mobile_group'].mean()
    if plot ==1:
        plt.figure(figsize=(25,1))
        sns.lineplot(data=id_data,x='second',y='acceleration_x')
        sns.lineplot(data=id_data,x='second',y='acceleration_y')
        sns.lineplot(data=id_data,x='second',y='acceleration_z')
        plt.figure(figsize=(25,1))
        sns.lineplot(data=id_data,x='second',y='gyro_x')
        sns.lineplot(data=id_data,x='second',y='gyro_y')
        sns.lineplot(data=id_data,x='second',y='gyro_z')
        plt.figure(figsize=(25,1))
        sns.lineplot(data=id_data,x='second',y='Speed')
        plt.figure(figsize=(25,1))
        sns.lineplot(data=id_data,x='second',y='Bearing')
    return [triptime,Accuracy,DangerousBearingRatio,DangerousDeAccRatio,Stay_in_lane_Ratio,minspeed,meanspeed,sd_speed,t25_quan_speed,t50_quan_speed,t75_quan_speed,max_speed,ratio_at_0,ratio_at_25per,ratio_below_50per,ratio_above_50per,ratio_above_75per,ratio_above_90per,ratio_at_maxspeed,mobile_type]

#for i in df['bookingID'].unique():
#	model_df.loc[i] = summerize(i)

def build_model_df(i):
	model_df.loc[i] = summerize(i)

if __name__ == '__main__':
	pool = Pool(processes=4)
	outputs = pool.map(build_model_df,df['bookingID'].unique())
	pool.close()
	pool.join()

model_df.to_csv('C:/Users/minhcq/Documents/safety/feature_extracted_2.csv')