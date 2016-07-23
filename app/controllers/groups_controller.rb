class GroupsController < ApplicationController
  def index
    @groups = Group.where.not(is_hidden_page: true).order(updated_at: :desc)
  end

  def new
    @group = Group.new
  end

  def create
    @group = ::Groups::CreateService.new(group_params).execute
    if @group.saved?
      redirect_to group_path(@group.uuid), notice: "'#{@group.name}' を作成しました。"
    else
      render 'new'
    end
  end

  def show
    @group = Group.where(uuid: params[:uuid]).first
  end

  def edit
    @group = Group.where(uuid: params[:uuid]).first
  end

  def update
    status = ::Groups::UpdateService.new(Group.where(uuid: params[:uuid]), group_params).execute
    if status
      redirect_to :action => "show", notice: "編集しました。"
    else
      render 'edit'
    end 
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :is_hidden_page)
  end
end
