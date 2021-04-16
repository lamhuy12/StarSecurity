-- US EDIT PROFILE
--get data user by user name
select * from Account
select [userName], [password], [address], [dayOfBirth], [phoneNumber], [email], [gender], [imageURL], [role]
from Account where [userName] = '' and [statusAccountID] = 'Active'
--update data user to database
update Account 
set [userName] = '', [password] = '', [address] = '', [dayOfBirth] = '', [phoneNumber] = '', [email] = '', [gender] = '', [imageURL] = '', [role] = '' 
where [userName] = ''
-- US View process of moderator
--Get list moderator in team
select [userName] from TeamMember where [teamID] = ''
--Get prosses of a moderator of a request
select count(resultRequestID) from ResultRequest where resolver = 'moderator name' and requestID = ''
-- US Accept new account
--Get list Account need accept
select [userName] from Account where [statusAccountID] = 'NotActive'
--accept a account need accept
update Account set [statusAccountID] = 'Active' where [userName] = ''
-- US View list Anti-Fanpages
--Get list Anti-Fanpages
select * from SocialNetworkGroup where isAnti = 'true'
--Get list Anti-fanpages from a Social Network
select * from SocialNetworkGroup where isAnti = 'true' and socialNetworkID = ''
-- US View a Anti-Fanpages
--Get a Anti-Fanpages
select * from SocialNetworkGroup where isAnti = 'true' and groupID = ''
--Get article of a Anti-Fanpages
select * from Article a join SocialNetworkGroup  s on a.groupID = s.groupID where a.groupID = '' and  s.isAnti = 'true'

-- get list result request of a celebrity
select * from ResultRequest as RR join (select * from Request where ownerRequest = 'tiennguyen5') as R on RR.requestID = R.requestID

-- get profile of a celebrity
select * from Account where userName = ''