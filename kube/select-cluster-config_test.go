package main

import "testing"

func Test_main(t *testing.T) {
	type args struct {
		awsProfile string
	}
	tests := []struct {
		name        string
		args        args
		wantErr     bool
		wantSuccess bool
	}{
		{
			name: "Success",
			args: args{
				awsProfile: "test",
			},
			wantErr:     false,
			wantSuccess: true,
		},
		{
			name: "Fail",
			args: args{
				awsProfile: "%",
			},
			wantErr:     true,
			wantSuccess: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			b, err := main(tt.args.arg)
			if (err != nil) != tt.wantErr {
				t.Errorf("main() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if b != tt.wantSuccess {
				t.Errorf("main() = %v, wantSuccess %v", b, tt.wantSuccess)
			}
		})
	}
}
