"""
Metropolis Twitter Network: (multiple crawl)
This script do the following tasks:
1. Get the user followers
2. Get the profiles that satisfy the condition (Metropolis)
3. Save the information
"""

import time
import os
import AllTwitterKeys
import tweepy
import csv
import random


# setting up Twitter Authentication
class TwitterAuthentication:
    # constructor
    def __init__(self):
        pass

    @staticmethod
    def twitter_authenticate():
        auth = tweepy.OAuthHandler(AllTwitterKeys.key_2['consumer'], AllTwitterKeys.key_2['consumerSecret'])
        auth.set_access_token(AllTwitterKeys.key_2['access'], AllTwitterKeys.key_2['accessSecret'])
        return auth


# extracting data of the Twitter Profiles
class TwitterDataExtraction:
    def __init__(self, total_samples_num):
        self.current_num_of_followers = 0
        self.current_num_of_followings = 0
        self.current_user = ''
        self.total_sample_counter = 0
        self.total_samples_num = total_samples_num
        self.twitter_authenticator = TwitterAuthentication()
        auth = self.twitter_authenticator.twitter_authenticate()
        self.api = tweepy.API(auth_handler=auth, wait_on_rate_limit=True,
                              wait_on_rate_limit_notify=True,
                              retry_errors=[401, 403, 404, 418, 500, 503],  # https://www.myintervals.com/api/errors.php
                              retry_count=5, retry_delay=5)

        # saving the required information
        self.CSVFile = '.csv'
        self.TxtFile = '.txt'

        # creating files to save the information
        self.to_from_file = 'to_from_records' + self.CSVFile
        self.collected_ids = 'collected_ids' + self.TxtFile
        self.user_profile_info = 'user_profile_info' + self.CSVFile
        self.recordTime = 'recordTime' + self.CSVFile

        # save the information in the desired folder location
        rootPath = './SamplingData_Final'
        self.backslash = '/'
        self.FolderToFrom = rootPath + self.backslash + self.to_from_file
        self.FolderCollectedIDs = rootPath + self.backslash + self.collected_ids
        self.FolderProfileInfo = rootPath + self.backslash + self.user_profile_info
        self.FolderRecordTime = rootPath + self.backslash + self.recordTime

        # open files
        # To -> From with Follower and Following Numbers
        self.SaveToFrom = open(self.FolderToFrom, 'w', encoding='utf-8')
        self.SaveToFromWriter = csv.writer(self.SaveToFrom, quoting=csv.QUOTE_MINIMAL)
        self.SaveToFromWriter.writerow(['To', 'From',
                                        'To_Follower_Num', 'From_Follower_Num',
                                        'To_Following_Num', 'From_Following_Num'])
        # containing separate files containing the Followers' IDs
        self.SaveCollectedIDs = open(self.FolderCollectedIDs, 'w', encoding='utf-8')
        # csv containing all the profile information
        self.SaveUserProfileInfo = open(self.FolderProfileInfo, 'w', encoding='utf-8')
        self.SaveProfileInfoWriter = csv.writer(self.SaveUserProfileInfo, quoting=csv.QUOTE_MINIMAL)
        self.SaveProfileInfoWriter.writerow(['name_twitter', 'id_str', 'screen_name', 'location', 'description',
                                             'verified', 'protected', 'followers_count', 'friends_count',
                                             'statuses_count', 'created_at'])
        # time information for each chunk
        self.SaveRecordTime = open(self.FolderRecordTime, 'w', encoding='utf-8')
        self.SaveRecordTimeWriter = csv.writer(self.SaveRecordTime, quoting=csv.QUOTE_MINIMAL)
        self.SaveRecordTimeWriter.writerow(['SampleCount', 'Time(sec)'])

    def save_records(self, record_information_list):

        # the following information need to be saved (100 millions)
        # track the timing for each 1 million
        # To -> From
        # csv containing all the required information
        # containing separate files containing the IDs 100 Million

        # save the info in to_from_records file
        # self.SaveRecordTime = open(self.FolderToFrom, 'w', encoding='utf-8')
        self.SaveToFromWriter.writerow([record_information_list[0], record_information_list[4],
                                        record_information_list[1], record_information_list[10],
                                        record_information_list[2], record_information_list[11]])
        # self.SaveToFrom.close()

        # save the IDs
        # self.SaveCollectedIDs = open(self.FolderCollectedIDs, 'w', encoding='utf-8')
        self.SaveCollectedIDs.write(str(record_information_list[4]) + '\n')
        # self.SaveCollectedIDs.close()

        # save profile information
        # self.SaveUserProfileInfo = open(self.FolderProfileInfo, 'w', encoding='utf-8')
        self.SaveProfileInfoWriter.writerow(
            [record_information_list[3], record_information_list[4], record_information_list[5],
             record_information_list[6], record_information_list[7], record_information_list[8],
             record_information_list[9], record_information_list[10], record_information_list[11],
             record_information_list[12], record_information_list[13]])
        # self.SaveRecordTime.close()

    # Root Node information
    def get_profile_info(self, userID):
        loop_counter_profile = True
        dict_node_info = {'CurrentNode': 0, 'CurrentNodeFollowerNum': 0,
                          'CurrentNodeFollowingNum': 0, 'CurrentNodeMembers': []}

        # initialize variables
        name_twitter = None
        user_id = 0
        screen_name = None
        location = None
        description = None
        verified = None
        protected = None
        followers_count = None
        friends_count = None
        statuses_count = None
        created_at = None

        while loop_counter_profile:
            try:
                user_info = self.api.get_user(userID)
                # getting the initial user information
                if user_info.protected == False and 1 < user_info.followers_count < 75000:
                    name_twitter = user_info.name
                    user_id = user_info.id_str
                    screen_name = user_info.screen_name
                    location = user_info.location
                    description = user_info.description
                    verified = user_info.verified
                    protected = user_info.protected
                    followers_count = user_info.followers_count
                    friends_count = user_info.friends_count
                    statuses_count = user_info.statuses_count
                    created_at = user_info.created_at
                    # initial user
                    self.current_num_of_followers = followers_count
                    self.current_num_of_followings = friends_count
                    self.current_user = user_id
                    initial_profile_info_list = [self.current_user, self.current_num_of_followers,
                                                 self.current_num_of_followings,
                                                 name_twitter, str(user_id), screen_name,
                                                 location, description, verified, protected, followers_count,
                                                 friends_count, statuses_count, created_at]
                    self.save_records(record_information_list=initial_profile_info_list)
                    # when found break loop
                    loop_counter_profile = False

                else:
                    print('Not Satisfying the conditions user: {0}'.format(userID))
                    loop_counter_profile = False
                    break

            except tweepy.TweepError as error:
                print('Error Generated by Tweepy')
                # print(error.reason)
                if error.api_code == 50 or error.api_code == 63:
                    print('User either suspended or not found: {0}'.format(userID))
                    break
                if error.api_code == 34:
                    print('{0} account doesn’t exist'.format(userID))
                    break

            # break the while loop
            except StopIteration:
                print('Break While Loop')
                break

            completeData = [user_id, screen_name, name_twitter,
                            location, description, verified, protected,
                            followers_count, friends_count, statuses_count, created_at]
            print('Initial User Information')
            print(completeData)

        # get the followers of that initial profile
        counter = 0
        reset_counter = 0
        loop_counter = True
        backoff_timer = 2  # counter for timer
        initial_profile_followers = []
        while loop_counter:
            try:
                for followersIDs in tweepy.Cursor(self.api.followers_ids, id=userID, count=5000).items():
                    initial_profile_followers.append(followersIDs)
                    time.sleep(0.01)
                    reset_counter += 1
                    # this is reducing the waiting time
                    if reset_counter % 74000 == 0:
                        reset_counter = 0
                        time.sleep(30)  # changing the time from 60 to 30

                    counter += 1
                    # max collection 5*15K =75K in 15 mins
                    # max request of 15 in 15 mins.
                break

            except tweepy.TweepError as error:
                if error.api_code == 50 or error.api_code == 63:  # 50 not found, 63 suspended
                    print('User either suspended or not found: {0}'.format(userID))
                    break
                if error.api_code == 34:
                    print('{0} account doesn’t exist'.format(userID))
                    break

                print(error.reason)
                time.sleep(60 * backoff_timer)
                sleep_time = 60 * backoff_timer
                print('Error Generated by Tweepy API sleep {0} seconds.'.format(round(sleep_time, 2)))
                backoff_timer += 1
                continue

            except Exception as error:
                print("Exception using the the API")
                print(error)
                continue

            # break the while loop
            except StopIteration:
                print('Break While Loop')
                break

        #print("Completed:{0} -- Followers Collected {1} ".format(userID, counter))
        dict_node_info['CurrentNode'] = int(user_id)
        dict_node_info['CurrentNodeFollowerNum'] = followers_count
        dict_node_info['CurrentNodeFollowingNum'] = friends_count
        dict_node_info['CurrentNodeMembers'] = initial_profile_followers
        #print(dict_node_info)
        self.get_lookup_users(user_node_info_dict=dict_node_info)

    # get the followers of the next set of IDs
    def get_followers(self, next_nodes_dist):

        dict_current_nodes_info = {'CurrentNode': [], 'CurrentNodeFollowerNum': [],
                                    'CurrentNodeFollowingNum': [], 'CurrentNodeMembers': []}

        get_num_of_current_nodes = []
        if isinstance(next_nodes_dist['NextNodes'], int):
            get_num_of_current_nodes.append(next_nodes_dist['NextNodes'])
        else:
            get_num_of_current_nodes = next_nodes_dist['NextNodes']

        for index in range(0, len(get_num_of_current_nodes)):
            get_current_node = next_nodes_dist['NextNodes'][index]
            get_current_node_followers = next_nodes_dist['NextNodeFollowerNum'][index]
            get_current_node_followings = next_nodes_dist['NextNodeFollowingNum'][index]

            counter = 0
            reset_counter = 0
            loop_counter = True
            backoff_timer = 2  # counter for timer
            total_current_followerID_list = []
            while loop_counter:
                try:
                    for follower_id in tweepy.Cursor(self.api.followers_ids, id=get_current_node, count=5000).items():

                        total_current_followerID_list.append(int(follower_id))
                        time.sleep(0.01)
                        counter += 1
                        # max collection 5*15K =75K in 15 mins.
                        # max request of 15 in 15 mins.
                    break

                except tweepy.TweepError as error:
                    if error.api_code == 50 or error.api_code == 63:  # 50 not found, 63 suspended
                        print('User either suspended or not found: {0}'.format(get_current_node))
                        break
                    if error.api_code == 34:
                        print('{0} account doesn’t exist'.format(get_current_node))
                        break

                    print(error.reason)
                    time.sleep(60 * backoff_timer)
                    sleep_time = 60 * backoff_timer
                    print('Error Generated by Tweepy API sleep {0} seconds.'.format(round(sleep_time, 2)))
                    backoff_timer += 1
                    continue

                except Exception as error:
                    print("Exception using the the API")
                    print(error)
                    continue

                # break the while loop
                except StopIteration:
                    print('Break While Loop')
                    break

            # this is reducing the waiting time
            if reset_counter % 14 == 0:
                reset_counter = 0
                time.sleep(30)  # changing the time from 60 to 30
            reset_counter += 1

            print("Completed:{0} -- Followers Collected {1} ".format(get_current_node, counter))
            dict_current_nodes_info['CurrentNode'].append(get_current_node)
            dict_current_nodes_info['CurrentNodeFollowerNum'].append(get_current_node_followers)
            dict_current_nodes_info['CurrentNodeFollowingNum'].append(get_current_node_followings)
            dict_current_nodes_info['CurrentNodeMembers'].append(total_current_followerID_list)
        # return this to get the profile
        self.get_lookup_users(user_node_info_dict=dict_current_nodes_info)

    # this will chunk the followers to get the profile information
    def chunker(self, sequence, size):
        return (sequence[position:position + size] for position in range(0, len(sequence), size))

    # this will calculate the metropolis hastings
    def metropolis_calculation(self, current_follower_num, next_follower_num):

        acceptance = min(current_follower_num / next_follower_num, 1)  # determine among the value
        # generate random value
        random_unif_val = random.uniform(0, 1)
        """
        print('Current: {1} -- Next: {0}'.format(next_follower_num, current_follower_num))
        print(random_unif_val, acceptance)
        """
        # accept or reject
        if random_unif_val <= acceptance:
            return True
        else:
            return False

    def get_lookup_users(self, user_node_info_dict):

        # this list is calculating the number of elements in the dict
        num_of_current_nodes = []

        # get the next set of nodes
        next_nodes = []
        next_nodes_followers = []
        next_node_followings = []
        #next_samples_disc = {'NextNodes' = [], 'NextNodeFollowerNum': [], 'CurrentNodeFollowingNum': []}
        next_samples_dict = {}

        # get the total number of current nodes
        if isinstance(user_node_info_dict['CurrentNode'], int):
            num_of_current_nodes.append(user_node_info_dict['CurrentNode'])
        else:
            num_of_current_nodes = user_node_info_dict['CurrentNode']

        # looping through the dict elements
        BreakLoop = False
        for index in range(0, len(num_of_current_nodes)):
            each_list_size = 100
            count_group = 0
            lookup_users_counter = 0
            # get the required items from the dict
            if isinstance(user_node_info_dict['CurrentNode'], int) and \
                    isinstance(user_node_info_dict['CurrentNodeFollowerNum'], int) and \
                    isinstance(user_node_info_dict['CurrentNodeFollowingNum'], int):
                self.current_user = user_node_info_dict['CurrentNode']
                self.current_num_of_followers = user_node_info_dict['CurrentNodeFollowerNum']
                self.current_num_of_followings = user_node_info_dict['CurrentNodeFollowingNum']
                user_id_list = user_node_info_dict['CurrentNodeMembers']
            else:
                self.current_user = user_node_info_dict['CurrentNode'][index]
                self.current_num_of_followers = user_node_info_dict['CurrentNodeFollowerNum'][index]
                self.current_num_of_followers = user_node_info_dict['CurrentNodeFollowingNum'][index]
                user_id_list = user_node_info_dict['CurrentNodeMembers'][index]

            # get the profile information in chunks
            for group_ids in self.chunker(user_id_list, each_list_size):

                collected_user_info = self.api.lookup_users([group_ids])

                # this will pause the API for 30 sec.
                if lookup_users_counter % 800 == 0:
                    lookup_users_counter = 0
                    time.sleep(30)
                lookup_users_counter += 1

                count_satisfied_user = 0
                start_time_chunk = time.time()

                for sampled_user_info in collected_user_info:
                    # condition on protective A/C and 0 followers
                    if sampled_user_info.protected == False and 1 < sampled_user_info.followers_count < 75000:
                        sampled_user_followers_count = sampled_user_info.followers_count
                        metropolis_decision = self.metropolis_calculation(
                            current_follower_num=self.current_num_of_followers,
                            next_follower_num=sampled_user_followers_count)
                        if metropolis_decision == True:
                            count_satisfied_user += 1
                            self.total_sample_counter += 1

                            current_user = self.current_user
                            current_num_followers = self.current_num_of_followers
                            current_num_followings = self.current_num_of_followings

                            # collect the data when the sample is satisfied
                            sample_NameTwitter = sampled_user_info.name
                            sample_id_str = sampled_user_info.id_str
                            sample_screen_name = sampled_user_info.screen_name
                            sample_location = sampled_user_info.location
                            sample_description = sampled_user_info.description
                            sample_verified = sampled_user_info.verified
                            sample_protected = sampled_user_info.protected
                            sample_followers_count = sampled_user_info.followers_count
                            sample_friends_count = sampled_user_info.friends_count
                            sample_statuses_count = sampled_user_info.statuses_count
                            sample_created_at = sampled_user_info.created_at
                            user_profile_info_list = [current_user, current_num_followers, current_num_followings,
                                                      sample_NameTwitter, str(sample_id_str),
                                                      sample_screen_name, sample_location, sample_description,
                                                      sample_verified, sample_protected, sample_followers_count,
                                                      sample_friends_count, sample_statuses_count, sample_created_at]
                            # save the profile information
                            self.save_records(record_information_list=user_profile_info_list)
                            # collect the next set of samples
                            next_nodes.append(int(sample_id_str))
                            next_nodes_followers.append(sample_followers_count)
                            next_node_followings.append(sample_friends_count)

                            if self.total_sample_counter % 100 == 0:
                                print('Sample Collected: {0}'.format(self.total_sample_counter))
                                # end_time_chunk = round((time.time() - start_time_chunk) / 60, 2)
                                end_time_chunk = round((time.time() - start_time_chunk) / 60, 5)
                                self.SaveRecordTimeWriter.writerow([self.total_sample_counter, end_time_chunk])

                            # this loop is used to count the total number of samples that is required
                            #print(self.total_sample_counter, self.total_samples_num)
                            if self.total_sample_counter == self.total_samples_num:
                                print('Required Samples Collected: {0}'.format(self.total_sample_counter))
                                BreakLoop = True
                                break
                            else:
                                continue
                        else:
                            # print('Metropolis Dissatisfied')
                            continue
                    else:
                        # print('Consider Next User as {0} A/C Protected or 0 Followers'.format(sampled_user_info.screen_name))
                        continue
                # this break the loop once all the required samples are collected
                if BreakLoop:
                    break
                """
                print('Group: {2} -- Satisfied Users: {0} out of {1}'.format(count_satisfied_user,
                                                                             len(collected_user_info),
                                                                             count_group))
                """
                count_group += 1
            if BreakLoop:
                #break
                return

        next_samples_dict['NextNodes'] = next_nodes
        next_samples_dict['NextNodeFollowerNum'] = next_nodes_followers
        next_samples_dict['NextNodeFollowingNum'] = next_node_followings
        print('Collected Till Now: {0}'.format(self.total_sample_counter))
        #print(len(next_samples_dict['NextNodes']))
        #print(next_samples_dict)
        # go back to the function to get the followers
        self.get_followers(next_nodes_dist=next_samples_dict)


if __name__ == "__main__":
    StartTime = time.time()
    # save the information in a folder
    FolderPath = './SamplingData_Final'
    try:
        if os.path.isdir(FolderPath):
            pass
        else:
            os.makedirs(FolderPath)
    except IOError as err:
        print(err.reason)

    client = TwitterDataExtraction(total_samples_num=600)
    user = 'gatitasexy07'
    client.get_profile_info(userID=user)
    print('Total Exec. Time: {0} min'.format(round((time.time() - StartTime) / 60, 4)))
    print('EOF')
