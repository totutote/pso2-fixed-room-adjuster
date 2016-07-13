module RoomMembers
  class OrganizeService < BaseService
    def initialize(room)
      @room = room
    end

    def execute
      room_count = ((@room.max_player - 1) / 12) + 1
      rm_ld_candidates = @room.room_members.where(acceptable_room_leader: true).limit(room_count)
      pt_ld_candidates = @room.room_members.where(acceptable_party_leader: true).where.not(id: candidate_ids(rm_ld_candidates)).limit(room_count * 4 - rm_ld_candidates.count) 
      nm_member_candidates = @room.room_members.where.not(id: (candidate_ids(rm_ld_candidates) + candidate_ids(pt_ld_candidates))).limit(room_count * 12 - (rm_ld_candidates.count + pt_ld_candidates.count))
 
      (1..room_count).each do |i|
        organize_one_room(i, rm_ld_candidates.first, pt_ld_candidates, nm_member_candidates)
      end
    end

    private

    def candidate_ids(candidates)
      candidates.collect {|candidate| candidate.id}
    end

    def shift_num_of_candidates(rm_lds, pt_lds, nm_mems, room_member_num)
      
      lm_ld = rm_lds.shift
      
      
    end

    def organize_one_room(room_num, rm_ld, pt_lds, nm_members)
       if rm_ld
         rm_ld.room_number = room_num
         rm_ld.party_number = 1
         rm_ld.is_room_leader = true
         rm_ld.save
       end
       plus_member_number = 0
       plus_member_number = 1 if rm_ld
       pt_lds.each_with_index do |pt_ld, i|
         pt_ld.room_number = room_num
         pt_ld.party_number = 1 + plus_member_number
         pt_ld.is_party_leader = true
         pt_ld.save
       end
       leadr_incl = plus_member_number + pt_lds.count
       party_count = (plus_member_number + pt_lds.count + nm_members.count) / 4
       nm_members.each_with_index do |nm_member, i|
         nm_member.room_number = room_num
         nm_member.party_number = party_number_mem(i, leadr_incl, party_count)
         nm_member.save
       end 
    end

    def party_number_mem(index, leadr_incl, max_party_member)
      ##index = index + index / (leader_incl / max_party_member) 

      party_id_tmp = (index / max_party_member) + 1
      if party_id_tmp <= leadr_incl
        if index == max_party_member - 1
          party_id_tmp + 1
        end
      end
      party_id_tmp
    end

  end
end
