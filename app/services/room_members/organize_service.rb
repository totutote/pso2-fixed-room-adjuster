module RoomMembers
  class OrganizeService < BaseService
    def initialize(room)
      @room = room
    end

    def execute
      @room.room_members.update(room_number: nil, party_number: nil, is_room_leader: nil, is_party_leader: nil)
      if @room.max_player.blank?
        total_member_count = @room.room_members.count
        room_count = room_count(total_member_count)
        room_max_player = total_member_count
        total_pt_num = (total_member_count.to_f / 4).ceil
      else 
        total_member_count = @room.max_player > @room.room_members.count ? @room.room_members.count : @room.max_player
        room_count = room_count(total_member_count)
        room_max_player = @room.max_player
        total_pt_num = (total_member_count.to_f / 4).ceil
      end
      rm_ld_cands = @room.room_members.where(acceptable_room_leader: true).order(:id).limit(room_count).to_a
      pt_ld_cands = @room.room_members.where(acceptable_party_leader: true).where.not(id: candidate_ids(rm_ld_cands)).order(:id).limit(total_pt_num - rm_ld_cands.count).to_a
      nm_member_cands = @room.room_members.where.not(id: (candidate_ids(rm_ld_cands) + candidate_ids(pt_ld_cands))).order(:id).limit(room_max_player - (rm_ld_cands.count + pt_ld_cands.count)).to_a
      max_room_member_num = ((rm_ld_cands.count + pt_ld_cands.count + nm_member_cands.count) / room_count.to_f).ceil
      rooms = []
      (1..room_count).each do |i|
        rm_ldc, pt_ldc, nm_memc = shift_num_of_candidates(rm_ld_cands, pt_ld_cands, nm_member_cands, room_count, max_room_member_num)
        one_room = organize_one_room(i, rm_ldc, pt_ldc, nm_memc)
        rooms.push(one_room)
      end
      save_rooms(rooms)
    end

    private

    def room_count(total_member_count)
      (total_member_count / 12.to_f).ceil
    end

    def initialize_parties
      {1 => [], 2 => [], 3 => []}
    end

    def candidate_ids(candidates)
      candidates.collect {|candidate| candidate.id}
    end

    def shift_num_of_candidates(rm_lds, pt_lds, nm_mems, room_count, max_room_member_num)
      pt_count = (max_room_member_num.to_f / 4).ceil
      rm_ld_r = rm_lds.shift
      pt_ld_count = rm_ld_r.blank? ? 0 : 1
      pt_lds_r = pt_lds.shift(pt_count - pt_ld_count)
      pt_ld_count = pt_ld_count + pt_lds.count
      nm_mem_r = nm_mems.shift(max_room_member_num - pt_ld_count)
      [rm_ld_r, pt_lds_r, nm_mem_r]
    end

    def organize_one_room(room_num, rm_ld, pt_lds, nm_members)
       parties = initialize_parties
       if rm_ld
         rm_ld.is_room_leader = true
         parties[1].push(rm_ld)
       end
       plus_member_number = 0
       plus_member_number = 1 unless rm_ld.blank?
       pt_lds.each_with_index do |pt_ld, i|
         pt_ld.is_room_leader = true if (1 + plus_member_number + i) == 1
         pt_ld.is_party_leader = true
         parties[1 + plus_member_number + i].push(pt_ld)
       end
       leadr_incl = plus_member_number + pt_lds.count
       party_count = ((plus_member_number + pt_lds.count + nm_members.count).to_f / 4).ceil
       nm_members.each_with_index do |nm_member, i|
         pt_index = witch_min_parties(parties, party_count)
         nm_member.is_room_leader = true if pt_index == 1 && parties[pt_index].count == 0
         nm_member.is_party_leader = true if parties[pt_index].count == 0
         parties[pt_index].push(nm_member)
       end 
       parties
    end

    def witch_min_parties(parties, party_count)
      min_pt_num = 1
      parties.each do |i, party|
        break if party_count < i
        min_pt_num = i if parties[min_pt_num].count > party.count  
      end
      min_pt_num
    end

    def save_rooms(rooms)
      rooms.each_with_index do |room, room_num|
        room.each do |party_num, party|
          party.each_with_index do |member, i|
            member.room_number = room_num + 1
            member.party_number = party_num
            member.save
          end
        end
      end
    end

  end
end
