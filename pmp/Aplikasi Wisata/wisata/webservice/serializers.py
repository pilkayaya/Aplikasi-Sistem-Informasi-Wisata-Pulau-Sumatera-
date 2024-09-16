from rest_framework import serializers
from wisata_app.models import (
    User, StatusModel, Profile, KategoriProvinsi, KategoriObjekWisata, ObjekWisata, Operasional, Review
)
from django.contrib.auth import authenticate
from rest_framework.validators import UniqueValidator
from django.core.exceptions import ValidationError
from django.contrib.auth.password_validation import validate_password

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        username = data.get('username', '')
        password = data.get('password', '')

        if username and password:
            user = authenticate(username=username, password=password)
            if user:
                if user.is_active and user.is_pengguna:
                    data['user'] = user
                else:
                    msg = 'Status pengguna tidak aktif...'
                    raise ValidationError({'message': msg})
            else:
                msg = 'Anda tidak memiliki akses masuk...'
                raise ValidationError({'message': msg})
        else:
            msg = 'Anda harus mengisi username dan password...'
            raise ValidationError({'message': msg})
        return data
    
class RegisterSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(required = True, validators = [UniqueValidator(queryset = User.objects.all())])
    password = serializers.CharField(write_only = True, required = True, validators = [validate_password])
    password2 = serializers.CharField(write_only = True, required = True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'password2', 'is_active', 'is_pengguna', 'first_name', 'last_name']
        extra_kwargs = {
            'first_name' : {'required' : True},
            'last_name' : {'required' : True}
        }
    
    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({
                'password' : 'Password dan Ulang password tidak sama...'
            })
        return attrs
    
    def create(self, validated_data):
        user = User.objects.create(
            username = validated_data['username'],
            email = validated_data['email'],
            is_active = validated_data['is_active'],
            is_pengguna = validated_data['is_pengguna'],
            first_name = validated_data['first_name'],
            last_name = validated_data['last_name'], 
        )
        user.set_password(validated_data['password'])
        user.save()
        return user

class KategoriProvinsiSerializer(serializers.ModelSerializer):
    status = serializers.CharField(source='status.name')

    class Meta:
        model = KategoriProvinsi
        fields = ('id', 'provinsi', 'status')
    
class KategoriObjekWisataSerializer(serializers.ModelSerializer):
    status = serializers.CharField(source='status.name')

    class Meta:
        model = KategoriObjekWisata
        fields = ('id', 'kategori', 'deskripsi', 'status')

class OperasionalSerializer(serializers.ModelSerializer):
    objek_wisata = serializers.CharField(source='objek_wisata.nama')
    status = serializers.CharField(source='status.name', read_only=True)

    class Meta:
        model = Operasional
        fields = ('id', 'objek_wisata', 'hari_operasional', 'jam_buka', 'jam_tutup', 'tarif', 'status')
        read_only_fields = ('status',)

    def create(self, validated_data):
        status_instance = StatusModel.objects.first() 
        validated_data['status'] = status_instance
        return Operasional.objects.create(**validated_data)
    
class ObjekWisataSerializer(serializers.ModelSerializer):
    kategori_provinsi = serializers.StringRelatedField(source='kategori_provinsi.provinsi')
    kategori_objek_wisata = serializers.StringRelatedField(source='kategori_objek_wisata.kategori')
    status = serializers.CharField(source='status.name', read_only=True)
    operasional = OperasionalSerializer(many=True, read_only=True)
    foto = serializers.SerializerMethodField()

    class Meta:
        model = ObjekWisata
        fields = ('id', 'nama', 'alamat', 'keterangan', 'rating', 'ulasan', 'foto', 'link_gmaps', 'kategori_provinsi', 'kategori_objek_wisata', 'status', 'operasional')
        read_only_fields = ('status',)

    def create(self, validated_data):
        return ObjekWisata.objects.create(**validated_data)
    
    def get_foto(self, obj):
        if obj.foto:
            return self.context['request'].build_absolute_uri(obj.foto.url)
        return None


class ReviewSerializer(serializers.ModelSerializer):
    objek_wisata = serializers.CharField(source='objek_wisata.nama')
    user_profile = serializers.SerializerMethodField(read_only=True)
    user_profile_id = serializers.PrimaryKeyRelatedField(queryset=Profile.objects.all(), write_only=True)

    class Meta:
        model = Review
        fields = ['id', 'user_profile', 'user_profile_id', 'objek_wisata', 'komentar', 'rating', 'user_create', 'user_update', 'created_on', 'last_modified']

    def get_user_profile(self, obj):
        return obj.user_profile.user.username if obj.user_profile else None

    def create(self, validated_data):
        objek_wisata_nama = validated_data.pop('objek_wisata').get('nama')
        objek_wisata = ObjekWisata.objects.get(nama=objek_wisata_nama)
        validated_data['objek_wisata'] = objek_wisata

        user_profile_id = validated_data.pop('user_profile_id')
        validated_data['user_profile'] = user_profile_id

        return super().create(validated_data)
    
    def update(self, instance, validated_data):
        if 'objek_wisata' in validated_data:
            objek_wisata_nama = validated_data.pop('objek_wisata').get('nama')
            objek_wisata = ObjekWisata.objects.get(nama=objek_wisata_nama)
            validated_data['objek_wisata'] = objek_wisata

        if 'user_profile_id' in validated_data:
            user_profile_id = validated_data.pop('user_profile_id')
            validated_data['user_profile'] = user_profile_id

        return super().update(instance, validated_data)

# class ProfileSerializer(serializers.ModelSerializer):
#     foto = serializers.SerializerMethodField()

#     class Meta:
#         model = Profile
#         fields = '__all__'

#     def get_foto(self, obj):
#         if obj.foto:
#             return self.context['request'].build_absolute_uri(obj.foto.url)
#         return None

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['first_name', 'last_name']

class ProfileSerializer(serializers.ModelSerializer):
    foto = serializers.SerializerMethodField()
    user = UserSerializer(read_only=True)

    class Meta:
        model = Profile
        fields = ['id','foto', 'user', 'status']
        
    def get_foto(self, obj):
        if obj.foto:
            return self.context['request'].build_absolute_uri(obj.foto.url)
        return None



