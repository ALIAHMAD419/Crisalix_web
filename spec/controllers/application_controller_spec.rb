require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'OK'
    end
  end

  describe 'before_action' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'calls set_profile method' do
        expect(controller).to receive(:set_profile)
        get :index
      end

      it 'calls current_user_type method' do
        expect(controller).to receive(:current_user_type)
        get :index
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'does not call set_profile method' do
        expect(controller).not_to receive(:set_profile)
        get :index
      end

      it 'does not call current_user_type method' do
        expect(controller).not_to receive(:current_user_type)
        get :index
      end
    end
  end

  describe '#user_doctor?' do
    context 'when user is signed in' do
      let(:doctor) { FactoryBot.create(:doctor) }

      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(doctor)
      end

      it 'returns true for user_doctor?' do
        expect(controller.send(:user_doctor?)).to eq(true)
      end

      it 'returns false for user_patient?' do
        expect(controller.send(:user_patient?)).to eq(false)
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'returns false for user_doctor?' do
        expect(controller.send(:user_doctor?)).to eq(false)
      end

      it 'returns false for user_patient?' do
        expect(controller.send(:user_patient?)).to eq(false)
      end
    end
  end

  describe '#current_user_model' do
    context 'when user is signed in' do
      let(:doctor) { FactoryBot.create(:doctor) }

      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(doctor)
      end

      it 'returns Doctor class for current_user_model' do
        expect(controller.send(:current_user_model)).to eq(Doctor)
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'returns nil for current_user_model' do
        expect(controller.send(:current_user_model)).to be_nil
      end
    end
  end

  describe '#current_user_type' do
    context 'when user is signed in' do
      let(:doctor) { FactoryBot.create(:doctor) }

      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(doctor)
      end

      it 'assigns current user type to @current_user_type' do
        get :index
        expect(assigns(:current_user_type)).to eq(doctor.type)
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'does not assign current user type to @current_user_type' do
        get :index
        expect(assigns(:current_user_type)).to be_nil
      end
    end
  end
end
