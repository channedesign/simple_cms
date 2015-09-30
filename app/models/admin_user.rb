class AdminUser < ActiveRecord::Base

	# To configure a diffrent table name:
	# self.table_name = "admin_users"
	has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, through: :section_edits

	EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary']

	validates :first_name, presence:true, length: {maximum: 25}
	validates :last_name, presence:true, length: {maximum: 50}
	validates :username, presence:true, length: {within: 8..25}, uniqueness: true
	validates :email, presence:true, length: {maximum: 100}, format: {with: EMAIL_REGEX}, 
						uniqueness: true, confirmation: true


	validate :username_is_allowed
	#validate :no_new_users_on_saturday, :on => :create

	scope :sorted, lambda { order("last_name ASC, first_name ASC")}

	def name 
		"#{first_nam} #{last_name}"
	end


	private

		def username_is_allowed
			if FORBIDDEN_USERNAMES.include?(username)
				errors.add(:username, "Has been restrictec from use.")
			end
		end

		def no_new_users_on_saturday
			if Time.now.wday == 6
				errors[:base] << "No new users on Saturdays."
			end
		end

	#def name(first, last) 
	#	first = :first_name
	#	last = :last_name
	#	return first + last
	#end

	

end
